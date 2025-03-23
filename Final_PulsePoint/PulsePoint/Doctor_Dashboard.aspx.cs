using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Pulsepoint
{
    public partial class Doctor_Dashboard : Page
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
                FetchTodayAppointments();
                FetchUpcomingAppointments();
                UpdateAppointmentCount();
            }
        }

        // Shows how many appointments the doctor has today (usually confirmed or completed).
        private void FetchTodayAppointments()
        {
            int doctorId = (int)Session["DoctorId"];
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*) 
                    FROM Appointments
                    WHERE DoctorId = @DoctorId
                      AND CONVERT(date, AppointmentDateTime) = CONVERT(date, GETDATE())
                      AND Status IN ('Confirmed','Completed')
                ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DoctorId", doctorId);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblAppointmentCount.Text = count.ToString();
                }
            }
        }

        // Shows upcoming (future) appointments. 
        // If you only want Confirmed, use Status = 'Confirmed' in the WHERE clause.
        private void FetchUpcomingAppointments()
        {
            int doctorId = (int)Session["DoctorId"];
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
                    WHERE a.DoctorId = @DoctorId
                      AND a.AppointmentDateTime >= GETDATE()
                      AND a.Status = 'Confirmed'
                    ORDER BY a.AppointmentDateTime ASC
                ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DoctorId", doctorId);
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    UpcomingAppointmentsGridView.DataSource = dt;
                    UpcomingAppointmentsGridView.DataBind();
                }
            }
        }

        // If needed, unify or rename this method. Currently it's just a placeholder.
        private void UpdateAppointmentCount()
        {
            // Already done in FetchTodayAppointments, but you can unify if you want.
        }


        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginRegister.aspx");
        }
    }
}
