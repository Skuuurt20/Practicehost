using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Pulsepoint
{
    public partial class Patient_Appointment : System.Web.UI.Page
    {
        // Build a static list of times from 1:00 PM to 4:45 PM in 15-min increments.
        // You can adjust these as needed.
        private static readonly List<TimeSpan> AllowedTimeSlots = BuildTimeSlots();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Make sure user is logged in
                if (Session["PatientId"] == null)
                {
                    Response.Redirect("LoginRegister.aspx");
                    return;
                }
                FetchAppointments();
            }
        }

        // Fetch all appointments for this patient
        private void FetchAppointments()
        {
            if (Session["PatientId"] == null) return;

            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT AppointmentId, AppointmentDateTime, Status 
                    FROM Appointments 
                    WHERE PatientId = @PatientId
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", (int)Session["PatientId"]);
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    AppointmentsGridView.DataSource = dt;
                    AppointmentsGridView.DataBind();
                }
            }
        }

        // Book Appointment Button
        protected void bookbtn_Click(object sender, EventArgs e)
        {
            // Ensure user is logged in
            if (Session["PatientId"] == null)
            {
                ShowAlert("Please log in first.");
                return;
            }

            // Check if the patient already has an active appointment
            if (HasActiveAppointment((int)Session["PatientId"]))
            {
                ShowAlert("You already have an active appointment. Please cancel it or wait until it is completed before booking another.");
                return;
            }

            // Check if a date is selected
            if (Calendar1.SelectedDate == DateTime.MinValue)
            {
                ShowAlert("Please select a valid date from the calendar.");
                return;
            }

            // Check if a time slot is selected
            if (string.IsNullOrEmpty(timeslotddl.SelectedValue) || timeslotddl.SelectedValue == "No Available Times")
            {
                ShowAlert("Please select a valid time slot.");
                return;
            }

            // Combine date + time
            DateTime dateOnly = Calendar1.SelectedDate.Date;
            DateTime timeParsed = DateTime.Parse(timeslotddl.SelectedValue);
            DateTime appointmentDateTime = dateOnly.Add(timeParsed.TimeOfDay);

            // Check if the date/time is valid (>= 1753)
            if (appointmentDateTime < new DateTime(1753, 1, 1))
            {
                ShowAlert("Selected date/time is out of valid range.");
                return;
            }

            // Check if the slot is taken
            if (IsDateTimeTaken(appointmentDateTime))
            {
                ShowAlert("This time slot is already booked. Please choose another time.");
                return;
            }

            // Insert new appointment
            string medicalReason = ddlMedicalReason.SelectedValue;
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    INSERT INTO Appointments 
                        (AppointmentDateTime, PatientId, DoctorId, MedicalReason, Status, QueueNumber)
                    VALUES 
                        (@AppointmentDateTime, @PatientId, 1, @MedicalReason, 'Pending', 1)
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@AppointmentDateTime", appointmentDateTime);
                    cmd.Parameters.AddWithValue("@PatientId", (int)Session["PatientId"]);
                    cmd.Parameters.AddWithValue("@MedicalReason", medicalReason);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowAlert("Appointment booked successfully!");
            FetchAppointments(); // Refresh
        }

        // Calendar DayRender => limit 14 bookings, must book 1 day in advance
        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            // 1) Must book at least 1 day in advance
            if (e.Day.Date <= DateTime.Today)
            {
                DisableDayCell(e, true);
                return;
            }

            // 2) Count how many non-cancelled appts for this date
            int bookingsCount = GetBookingsCount(e.Day.Date);

            // Show "X/14" in the cell
            e.Cell.Controls.Add(new Literal
            {
                Text = $"<div class='booking-count'>{bookingsCount}/14</div>"
            });

            // 3) If 14 or more => fully booked => disable
            if (bookingsCount >= 14)
            {
                DisableDayCell(e, false);
            }
        }

        private void DisableDayCell(DayRenderEventArgs e, bool isPastOrToday)
        {
            e.Day.IsSelectable = false;
            e.Cell.Controls.Clear();
            if (isPastOrToday)
            {
                e.Cell.CssClass = "calendar-past";
            }
            else
            {
                e.Cell.CssClass = "calendar-fully-booked";
            }
        }

        private int GetBookingsCount(DateTime date)
        {
            int count = 0;
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*) 
                    FROM Appointments
                    WHERE CONVERT(date, AppointmentDateTime) = @SelectedDate
                      AND Status <> 'Cancelled'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SelectedDate", date.Date);
                    conn.Open();
                    count = (int)cmd.ExecuteScalar();
                }
            }
            return count;
        }

        // Called when user picks a date => build the timeslotddl
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            timeslotddl.Items.Clear();
            if (Calendar1.SelectedDate == DateTime.MinValue)
            {
                timeslotddl.Items.Add("Select Time");
                return;
            }

            DateTime selectedDate = Calendar1.SelectedDate.Date;

            // get the times that are taken
            List<TimeSpan> takenTimes = GetTakenTimes(selectedDate);

            bool isToday = (selectedDate == DateTime.Today);

            int countAvailable = 0;
            foreach (var slot in AllowedTimeSlots)
            {
                // if isToday => skip slots that are in the past
                if (isToday && slot <= DateTime.Now.TimeOfDay)
                {
                    continue;
                }

                // skip if taken
                if (takenTimes.Contains(slot))
                {
                    continue;
                }

                // otherwise add
                DateTime dt = DateTime.Today.Add(slot);
                string display = dt.ToString("hh:mm tt"); // e.g. "01:15 PM"
                timeslotddl.Items.Add(display);
                countAvailable++;
            }

            if (countAvailable == 0)
            {
                timeslotddl.Items.Add("No Available Times");
            }
        }

        // Return all non-cancelled appointment times for the given date
        private List<TimeSpan> GetTakenTimes(DateTime date)
        {
            var result = new List<TimeSpan>();
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT AppointmentDateTime
                    FROM Appointments
                    WHERE CONVERT(date, AppointmentDateTime) = @SelectedDate
                      AND Status <> 'Cancelled'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SelectedDate", date.Date);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DateTime appt = reader.GetDateTime(0);
                            result.Add(appt.TimeOfDay);
                        }
                    }
                }
            }
            return result;
        }

        // Build a list of 15-min increments from 1:00 PM to 4:45 PM
        private static List<TimeSpan> BuildTimeSlots()
        {
            var list = new List<TimeSpan>();
            DateTime start = DateTime.Today.AddHours(13);  // 1:00 PM
            DateTime end = DateTime.Today.AddHours(16.75); // 4:45 PM
            while (start <= end)
            {
                list.Add(start.TimeOfDay);
                start = start.AddMinutes(15);
            }
            return list;
        }

        // Check if slot is taken
        private bool IsDateTimeTaken(DateTime appointmentDateTime)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*)
                    FROM Appointments
                    WHERE AppointmentDateTime = @DateTime
                      AND Status <> 'Cancelled'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DateTime", appointmentDateTime);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return (count > 0);
                }
            }
        }

        // Check if patient has a pending/confirmed appointment
        private bool HasActiveAppointment(int patientId)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*) 
                    FROM Appointments
                    WHERE PatientId = @PatientId
                      AND Status IN ('Pending','Confirmed')
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", patientId);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return (count > 0);
                }
            }
        }

        // Cancel button in the GridView
        protected void CancelButton_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                int appointmentId = Convert.ToInt32(e.CommandArgument);
                CancelAppointment(appointmentId);
                FetchAppointments();
            }
        }

        private void CancelAppointment(int appointmentId)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    UPDATE Appointments 
                    SET Status = 'Cancelled' 
                    WHERE AppointmentId = @AppointmentId
                      AND Status = 'Pending'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@AppointmentId", appointmentId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginRegister.aspx");
        }

        private void ShowAlert(string message)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "alert",
                $"alert('{message}');",
                true
            );
        }
    }
}
