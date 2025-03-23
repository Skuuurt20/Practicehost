using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pulsepoint
{
    public partial class ManageAppointments : Page
    {
        // Ensure classic ASP.NET validators can work
        protected void Page_PreInit(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ensure the secretary is logged in; if not, redirect.
                if (Session["SecretaryId"] == null)
                {
                    Response.Redirect("LoginRegister.aspx");
                    return;
                }

                BindPendingAppointments();
                BindConfirmedAppointments();
            }
        }

        // ----------------- PENDING APPOINTMENTS -----------------
        private void BindPendingAppointments()
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT 
                        a.AppointmentId,
                        a.AppointmentDateTime,
                        (p.FirstName + ' ' + p.LastName) AS PatientName
                    FROM Appointments a
                    INNER JOIN Patients p ON a.PatientId = p.PatientId
                    WHERE a.Status = 'Pending'
                    ORDER BY a.AppointmentDateTime ASC
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtPending = new DataTable();
                    adapter.Fill(dtPending);
                    gvPendingAppointments.DataSource = dtPending;
                    gvPendingAppointments.DataBind();
                }
            }
        }

        protected void GvPendingAppointments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int appointmentId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Confirm")
            {
                ConfirmAppointment(appointmentId);
            }
            else if (e.CommandName == "CancelAppointment")
            {
                CancelPendingAppointment(appointmentId);
            }

            // Refresh both grids
            BindPendingAppointments();
            BindConfirmedAppointments();
        }

        private void ConfirmAppointment(int appointmentId)
        {
            // Just mark it Confirmed (no queue number needed)
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string confirmQuery = @"
                    UPDATE Appointments
                    SET Status = 'Confirmed'
                    WHERE AppointmentId = @Id
                      AND Status = 'Pending'
                ";
                using (SqlCommand cmd = new SqlCommand(confirmQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", appointmentId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void CancelPendingAppointment(int appointmentId)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    UPDATE Appointments
                    SET Status = 'Cancelled'
                    WHERE AppointmentId = @Id
                      AND Status = 'Pending'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", appointmentId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // ----------------- CONFIRMED APPOINTMENTS -----------------
        private void BindConfirmedAppointments()
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT 
                        a.AppointmentId,
                        a.AppointmentDateTime,
                        (p.FirstName + ' ' + p.LastName) AS PatientName,
                        a.Status
                    FROM Appointments a
                    INNER JOIN Patients p ON a.PatientId = p.PatientId
                    WHERE a.Status = 'Confirmed'
                    ORDER BY a.AppointmentDateTime ASC
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtConfirmed = new DataTable();
                    adapter.Fill(dtConfirmed);
                    gvConfirmedAppointments.DataSource = dtConfirmed;
                    gvConfirmedAppointments.DataBind();
                }
            }
        }

        protected void GvConfirmedAppointments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int appointmentId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "CancelConfirmed")
            {
                CancelConfirmedAppointment(appointmentId);
                // Refresh
                BindConfirmedAppointments();
            }
        }

        private void CancelConfirmedAppointment(int appointmentId)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    UPDATE Appointments
                    SET Status = 'Cancelled'
                    WHERE AppointmentId = @Id
                      AND Status = 'Confirmed'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", appointmentId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // SEARCH function for Confirmed Appointments
        protected void BtnSearchName_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearchName.Text.Trim();

            // If searchTerm is empty, revert to the full confirmed list
            if (string.IsNullOrEmpty(searchTerm))
            {
                BindConfirmedAppointments();
                return;
            }

            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    SELECT 
                        a.AppointmentId,
                        a.AppointmentDateTime,
                        (p.FirstName + ' ' + p.LastName) AS PatientName,
                        a.Status
                    FROM Appointments a
                    INNER JOIN Patients p ON a.PatientId = p.PatientId
                    WHERE a.Status = 'Confirmed'
                      AND (p.FirstName + ' ' + p.LastName) LIKE @Search
                    ORDER BY a.AppointmentDateTime ASC
                ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + searchTerm + "%");
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dtConfirmed = new DataTable();
                    adapter.Fill(dtConfirmed);
                    gvConfirmedAppointments.DataSource = dtConfirmed;
                    gvConfirmedAppointments.DataBind();
                }
            }
        }

        // ----------------- MANUAL BOOKING: Calendar + Time Slots -----------------
        // We want a day render that enforces "book 1 day in advance" and "max 14/day"
        protected void CalendarWalkIn_DayRender(object sender, DayRenderEventArgs e)
        {
            // 1) Must book at least 1 day in advance
            if (e.Day.Date <= DateTime.Today)
            {
                DisableDayCell(e, true);
                return;
            }

            // 2) Check how many non-cancelled appointments are already booked for this date
            int bookingsCount = GetBookingsCount(e.Day.Date);

            // Show "X/14"
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

        protected void CalendarWalkIn_SelectionChanged(object sender, EventArgs e)
        {
            // Whenever the user picks a new date, re-bind the time slots
            BindTimeSlotsForSelectedDate();
        }

        private void BindTimeSlotsForSelectedDate()
        {
            ddlTimeSlot.Items.Clear();
            // Always add a default item
            ddlTimeSlot.Items.Add(new ListItem("Select Time", ""));

            if (CalendarWalkIn.SelectedDate == DateTime.MinValue) return;

            DateTime selectedDate = CalendarWalkIn.SelectedDate.Date;

            // The base set of times you want to allow
            string[] allTimes =
            {
                "01:00 PM", "01:15 PM", "01:30 PM", "01:45 PM",
                "02:00 PM", "02:15 PM", "02:30 PM", "02:45 PM",
                "03:00 PM", "03:45 PM", "04:00 PM", "04:15 PM",
                "04:30 PM", "04:45 PM"
            };

            // Gather used times from DB
            var usedTimes = GetUsedTimes(selectedDate);

            // Add only free times
            foreach (var t in allTimes)
            {
                if (!usedTimes.Contains(t))
                {
                    ddlTimeSlot.Items.Add(t);
                }
            }
        }

        private System.Collections.Generic.HashSet<string> GetUsedTimes(DateTime date)
        {
            var used = new System.Collections.Generic.HashSet<string>();

            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    SELECT AppointmentDateTime
                    FROM Appointments
                    WHERE CONVERT(date, AppointmentDateTime) = @SelectedDate
                      AND Status <> 'Cancelled'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SelectedDate", date.Date);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DateTime dt = (DateTime)reader["AppointmentDateTime"];
                            // Convert to 12-hour time string (e.g. "01:15 PM")
                            string timeString = dt.ToString("hh:mm tt");
                            used.Add(timeString);
                        }
                    }
                }
            }
            return used;
        }

        // --------------- MANUAL BOOKING: Insert Appointment ---------------
        protected void BtnManualBook_Click(object sender, EventArgs e)
        {
            // First check if the page is valid
            if (!Page.IsValid)
            {
                return;
            }

            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string contactNumber = txtContactNumber.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validate walk-in date/time
            if (CalendarWalkIn.SelectedDate == DateTime.MinValue)
            {
                ShowAlert("Please select a valid date for the appointment.");
                return;
            }
            DateTime dateOnly = CalendarWalkIn.SelectedDate.Date;

            // Must book at least 1 day in advance
            if (dateOnly <= DateTime.Today)
            {
                ShowAlert("You must book at least one day in advance.");
                return;
            }

            if (string.IsNullOrEmpty(ddlTimeSlot.SelectedValue))
            {
                ShowAlert("Please select a time slot.");
                return;
            }

            DateTime timeOnly = DateTime.Parse(ddlTimeSlot.SelectedValue);
            DateTime appointmentDateTime = dateOnly.Add(timeOnly.TimeOfDay);

            // Check if the slot is already taken
            if (IsSlotTaken(appointmentDateTime))
            {
                ShowAlert("This time slot is already booked. Please choose another time.");
                return;
            }

            // Medical reason
            string medicalReason = ddlReason.SelectedValue;

            // Find or create patient record
            int patientId = FindOrCreatePatient(firstName, lastName, email, contactNumber, password);

            // Insert new appointment with Status = 'Pending'
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string insertAppt = @"
                    INSERT INTO Appointments 
                        (AppointmentDateTime, PatientId, DoctorId, MedicalReason, Status, QueueNumber)
                    VALUES 
                        (@ApptDateTime, @PatientId, 1, @Reason, 'Pending', 0)
                ";
                using (SqlCommand cmd = new SqlCommand(insertAppt, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptDateTime", appointmentDateTime);
                    cmd.Parameters.AddWithValue("@PatientId", patientId);
                    cmd.Parameters.AddWithValue("@Reason", medicalReason);
                    cmd.ExecuteNonQuery();
                }
            }

            // Clear input fields
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtContactNumber.Text = "";
            txtPassword.Text = "";
            CalendarWalkIn.SelectedDate = DateTime.MinValue;
            ddlTimeSlot.Items.Clear();
            ddlReason.SelectedIndex = 0;

            // Refresh grids
            BindPendingAppointments();
            BindConfirmedAppointments();
            ShowAlert("Appointment booked successfully!");
        }

        private int FindOrCreatePatient(string firstName, string lastName, string email, string contactNumber, string password)
        {
            int patientId = 0;
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();

                // Attempt to find existing patient by first & last name
                string findQuery = @"
                    SELECT PatientId
                    FROM Patients
                    WHERE FirstName = @FName
                      AND LastName = @LName
                ";
                using (SqlCommand cmd = new SqlCommand(findQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@FName", firstName);
                    cmd.Parameters.AddWithValue("@LName", lastName);

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        patientId = Convert.ToInt32(result);
                    }
                }

                // If not found, create new
                if (patientId == 0)
                {
                    string insertPatient = @"
                        INSERT INTO Patients (FirstName, LastName, Email, ContactNumber, Password)
                        OUTPUT INSERTED.PatientId
                        VALUES (@FName, @LName, @Email, @Contact, @Pwd)
                    ";
                    using (SqlCommand cmd = new SqlCommand(insertPatient, conn))
                    {
                        cmd.Parameters.AddWithValue("@FName", firstName);
                        cmd.Parameters.AddWithValue("@LName", lastName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Contact", contactNumber);
                        cmd.Parameters.AddWithValue("@Pwd", password);
                        patientId = (int)cmd.ExecuteScalar();
                    }
                }
            }
            return patientId;
        }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginRegister.aspx");
        }

        private bool IsSlotTaken(DateTime appointmentDateTime)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string query = @"
                    SELECT COUNT(*)
                    FROM Appointments
                    WHERE AppointmentDateTime = @ApptDateTime
                      AND Status <> 'Cancelled'
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ApptDateTime", appointmentDateTime);
                    int count = (int)cmd.ExecuteScalar();
                    return (count > 0);
                }
            }
        }

        private void ShowAlert(string message)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{message}');", true);
        }
    }
}
