using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Pulsepoint
{
    public partial class Patient_Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // If not logged in, redirect
                if (Session["PatientId"] == null)
                {
                    Response.Redirect("LoginRegister.aspx");
                    return;
                }

                LoadPatientNameAndActiveAppointment();
            }
        }

        private void LoadPatientNameAndActiveAppointment()
        {
            int patientId = (int)Session["PatientId"];

            // 1) Load the patient's name
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string nameQuery = @"
                    SELECT FirstName, LastName
                    FROM Patients
                    WHERE PatientId = @PatientId";

                using (SqlCommand cmd = new SqlCommand(nameQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", patientId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            lblPatientName.Text = $"{firstName} {lastName}";
                        }
                        else
                        {
                            lblPatientName.Text = "Valued Patient";
                        }
                    }
                }
            }

            // 2) Load any active appointment (Pending or Confirmed)
            //    We take the earliest upcoming appointment if multiple
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string apptQuery = @"
                    SELECT TOP 1 
                           AppointmentDateTime,
                           Status
                    FROM Appointments
                    WHERE PatientId = @PatientId
                      AND Status IN ('Pending','Confirmed')
                      AND AppointmentDateTime >= GETDATE()
                    ORDER BY AppointmentDateTime ASC";

                using (SqlCommand cmd = new SqlCommand(apptQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", patientId);
                    conn.Open();
                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            DateTime apptDateTime = (DateTime)rd["AppointmentDateTime"];
                            string status = rd["Status"].ToString();

                            // Always show date/time + status, no queue number
                            lblActiveAppointment.Text = $"{apptDateTime:MMMM dd, yyyy hh:mm tt} ({status})";
                        }
                        else
                        {
                            lblActiveAppointment.Text = "No active appointment";
                        }
                    }
                }
            }
        }

        protected void btnBookNow_Click(object sender, EventArgs e)
        {
            Response.Redirect("Patient_Appointment.aspx");
        }

        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginRegister.aspx");
        }
    }
}
