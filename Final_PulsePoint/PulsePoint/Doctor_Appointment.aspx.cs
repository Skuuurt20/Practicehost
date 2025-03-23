using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pulsepoint
{
    public partial class Doctor_Appointment : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["DoctorId"] == null)
                {
                    Response.Redirect("LoginRegister.aspx");
                    return;
                }

                // Default to "Today's Confirmed" in the dropdown
                ddlViewOption.SelectedIndex = 0;
                BindToggleAppointments("TodayConfirmed");
            }
        }

        // ==================== Toggleable View (Left Column) ====================
        // *** NOTE: The method name matches the .aspx: OnSelectedIndexChanged="ddlViewOption_SelectedIndexChanged"
        protected void ddlViewOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlViewOption.SelectedValue;
            BindToggleAppointments(selectedValue);
        }

        private void BindToggleAppointments(string viewOption)
        {
            int doctorId = Convert.ToInt32(Session["DoctorId"]);
            DateTime targetDate = DateTime.Today;
            string statusFilter;

            switch (viewOption)
            {
                case "TodayConfirmed":
                    targetDate = DateTime.Today;
                    statusFilter = "Confirmed";
                    break;
                case "TodayCompleted":
                    targetDate = DateTime.Today;
                    statusFilter = "Completed";
                    break;
                case "TomorrowConfirmed":
                    targetDate = DateTime.Today.AddDays(1);
                    statusFilter = "Confirmed";
                    break;
                default:
                    targetDate = DateTime.Today;
                    statusFilter = "Confirmed";
                    break;
            }

            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    SELECT 
                        a.AppointmentId,
                        a.AppointmentDateTime,
                        (p.FirstName + ' ' + p.LastName) AS PatientName,
                        a.MedicalReason,
                        a.Status
                    FROM Appointments a
                    INNER JOIN Patients p ON a.PatientId = p.PatientId
                    WHERE a.DoctorId = @DoctorId
                      AND CONVERT(date, a.AppointmentDateTime) = @ApptDate
                      AND a.Status = @Status
                    ORDER BY a.AppointmentDateTime ASC
                ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DoctorId", doctorId);
                    cmd.Parameters.AddWithValue("@ApptDate", targetDate.Date);
                    cmd.Parameters.AddWithValue("@Status", statusFilter);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvToggleAppointments.DataSource = dt;
                    gvToggleAppointments.DataBind();
                }
            }
        }

        // COMPLETE BUTTON for "TodayConfirmed" or "TomorrowConfirmed"
        protected void CompleteButton_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Complete")
            {
                int appointmentId = Convert.ToInt32(e.CommandArgument);
                MarkAppointmentAsComplete(appointmentId);

                // Refresh the same toggle view
                string currentSelection = ddlViewOption.SelectedValue;
                BindToggleAppointments(currentSelection);
            }
        }

        private void MarkAppointmentAsComplete(int appointmentId)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    UPDATE Appointments
                    SET Status = 'Completed'
                    WHERE AppointmentId = @ApptId
                      AND Status = 'Confirmed';
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptId", appointmentId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // ==================== Search by Date & Patient Name (Right Column) ====================
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Get the selected date from the calendar
            DateTime selectedDate = CalendarSearch.SelectedDate;
            if (selectedDate == DateTime.MinValue)
            {
                // No valid date => clear
                gvDateAppointments.DataSource = null;
                gvDateAppointments.DataBind();
                return;
            }

            string patientNameFilter = txtPatientName.Text.Trim();
            LoadAppointmentsForDate(selectedDate, patientNameFilter);
        }

        private void LoadAppointmentsForDate(DateTime date, string patientName)
        {
            int doctorId = Convert.ToInt32(Session["DoctorId"]);

            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                // Let the doctor see Confirmed or Completed on that date
                string query = @"
                    SELECT 
                        a.AppointmentId,
                        a.AppointmentDateTime,
                        (p.FirstName + ' ' + p.LastName) AS PatientName,
                        a.MedicalReason,
                        a.Status
                    FROM Appointments a
                    INNER JOIN Patients p ON a.PatientId = p.PatientId
                    WHERE a.DoctorId = @DoctorId
                      AND CONVERT(date, a.AppointmentDateTime) = @SearchDate
                      AND a.Status IN ('Confirmed','Completed')
                ";

                // If user typed a patient name, filter by partial match
                if (!string.IsNullOrEmpty(patientName))
                {
                    query += @"
                      AND (p.FirstName + ' ' + p.LastName) LIKE '%' + @PatientName + '%'
                    ";
                }

                query += " ORDER BY a.AppointmentDateTime ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DoctorId", doctorId);
                    cmd.Parameters.AddWithValue("@SearchDate", date.Date);

                    if (!string.IsNullOrEmpty(patientName))
                    {
                        cmd.Parameters.AddWithValue("@PatientName", patientName);
                    }

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvDateAppointments.DataSource = dt;
                    gvDateAppointments.DataBind();
                }
            }
        }

        // ==================== Calendar DayRender for X/14 Bookings ====================
        protected void CalendarSearch_DayRender(object sender, DayRenderEventArgs e)
        {
            // We'll show how many appointments are on each date (non-cancelled).
            // The doctor can see both past and future dates (no disabling).
            int bookingsCount = GetBookingsCount(e.Day.Date);

            // Add the "X/14" label in each cell
            e.Cell.Controls.Add(new Literal
            {
                Text = $"<div class='booking-count'>{bookingsCount}/14</div>"
            });

            // If fully booked => color it red
            if (bookingsCount >= 14)
            {
                e.Cell.CssClass = "calendar-fully-booked";
            }
            else if (e.Day.Date < DateTime.Today)
            {
                // Past date => show gray background
                e.Cell.CssClass = "calendar-past";
            }
        }

        private int GetBookingsCount(DateTime date)
        {
            int count = 0;
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    SELECT COUNT(*)
                    FROM Appointments
                    WHERE CONVERT(date, AppointmentDateTime) = @SelectedDate
                      AND Status <> 'Cancelled'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SelectedDate", date.Date);
                    count = (int)cmd.ExecuteScalar();
                }
            }
            return count;
        }

        // LOGOUT
        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginRegister.aspx");
        }
    }
}
