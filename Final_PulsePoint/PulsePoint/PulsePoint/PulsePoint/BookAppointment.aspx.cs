using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

namespace PulsePoint
{
    public partial class BookAppointment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load any existing appointments into the GridView if needed.
                LoadAppointments();
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            // Retrieve appointment details from form fields
            string fullName = txtFullName.Text.Trim();
            string contact = txtContact.Text.Trim();
            string email = txtEmail.Text.Trim();
            string reason = txtReason.Text.Trim();
            string timeSlot = ddlTimeSlots.SelectedValue;
            DateTime appointmentDate;

            if (!DateTime.TryParse(txtAppointmentDate.Text, out appointmentDate))
            {
                Response.Write("<script>alert('Invalid appointment date.');</script>");
                return;
            }

            // Validate: cannot book a past date
            if (appointmentDate.Date < DateTime.Now.Date)
            {
                Response.Write("<script>alert('Cannot book an appointment for a past date.');</script>");
                return;
            }

            // TODO: Insert the appointment into the database.
            // using(SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString))
            // {
            //     // INSERT appointment record with details: fullName, contact, email, reason, timeSlot, appointmentDate
            // }

            Response.Write("<script>alert('Appointment booked successfully.');</script>");
            LoadAppointments();
        }

        private void LoadAppointments()
        {
            // TODO: Retrieve appointments data from the database and bind to gvAppointments.
            // Example:
            // DataTable dt = new DataTable();
            // using(SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString))
            // {
            //     string query = "SELECT AppointmentTime, Status FROM Appointments WHERE PatientID = @PatientID";
            //     using(SqlCommand cmd = new SqlCommand(query, con))
            //     {
            //         cmd.Parameters.AddWithValue("@PatientID", /* current patient id */);
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
