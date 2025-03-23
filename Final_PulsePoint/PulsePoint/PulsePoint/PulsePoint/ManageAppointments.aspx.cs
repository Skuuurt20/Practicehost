using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PulsePoint
{
    public partial class ManageAppointments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadAppointments();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            LoadAppointments(searchTerm);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string appointmentId = btn.CommandArgument;

            // TODO: Retrieve the appointment details and open an edit interface.
            Response.Write("<script>alert('Edit functionality for Appointment ID: " + appointmentId + "');</script>");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string appointmentId = btn.CommandArgument;

            // TODO: Update the appointment status to 'Canceled' in the database.
            // using(SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString))
            // {
            //     string query = "UPDATE Appointments SET Status='Canceled' WHERE AppointmentID=@AppointmentID";
            //     using(SqlCommand cmd = new SqlCommand(query, con))
            //     {
            //         cmd.Parameters.AddWithValue("@AppointmentID", appointmentId);
            //         con.Open();
            //         cmd.ExecuteNonQuery();
            //     }
            // }
            Response.Write("<script>alert('Appointment canceled successfully.');</script>");
            LoadAppointments();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string appointmentId = btn.CommandArgument;

            // TODO: Delete the appointment record from the database.
            // using(SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString))
            // {
            //     string query = "DELETE FROM Appointments WHERE AppointmentID=@AppointmentID";
            //     using(SqlCommand cmd = new SqlCommand(query, con))
            //     {
            //         cmd.Parameters.AddWithValue("@AppointmentID", appointmentId);
            //         con.Open();
            //         cmd.ExecuteNonQuery();
            //     }
            // }
            Response.Write("<script>alert('Appointment deleted successfully.');</script>");
            LoadAppointments();
        }

        private void LoadAppointments(string searchTerm = "")
        {
            // TODO: Retrieve and bind appointment data.
            // DataTable dt = new DataTable();
            // using(SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString))
            // {
            //     string query = "SELECT AppointmentID, PatientName, AppointmentDate, AppointmentTime, ReasonForVisit, Status FROM Appointments WHERE 1=1";
            //     if (!string.IsNullOrEmpty(searchTerm))
            //         query += " AND (PatientName LIKE '%' + @SearchTerm + '%' OR CONVERT(varchar, AppointmentDate, 101) LIKE '%' + @SearchTerm + '%')";
            //     using(SqlCommand cmd = new SqlCommand(query, con))
            //     {
            //         if (!string.IsNullOrEmpty(searchTerm))
            //             cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);
            //         using(SqlDataAdapter da = new SqlDataAdapter(cmd))
            //         {
            //             da.Fill(dt);
            //         }
            //     }
            // }
            // gvAppointments.DataSource = dt;
            // gvAppointments.DataBind();
        }
    }
}
