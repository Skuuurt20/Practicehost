using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;

namespace PulsePoint
{
    public partial class LoginRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optionally check if a user is already logged in
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Retrieve login inputs
            string email = txtEmailLogin.Text.Trim();
            string password = txtPasswordLogin.Text.Trim();

            // Hash the password (using SHA256 in this example)
            string passwordHash = ComputeHash(password);

            // TODO: Implement actual database authentication logic.
            // Example (stub):
            // using(SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString))
            // {
            //     // Query database to verify email and passwordHash,
            //     // then retrieve user role.
            // }
            // For demonstration, assume successful login with role "Patient":
            string role = "Patient"; // or "Doctor"/"Secretary" as returned from DB

            // Role-based redirection
            if (role == "Patient")
                Response.Redirect("BookAppointment.aspx");
            else if (role == "Doctor")
                Response.Redirect("DoctorDashboard.aspx");
            else if (role == "Secretary")
                Response.Redirect("ManageAppointments.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Retrieve registration inputs
            string fullName = txtFullName.Text.Trim();
            string email = txtEmailRegister.Text.Trim();
            string contact = txtContact.Text.Trim();
            string password = txtPasswordRegister.Text.Trim();
            DateTime dob;
            DateTime.TryParse(txtDOB.Text.Trim(), out dob);

            // Hash the password
            string passwordHash = ComputeHash(password);

            // TODO: Insert the new patient record into the database.
            // using(SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString))
            // {
            //     // INSERT INTO PatientAccounts and/or Patients tables
            // }

            // Notify the user and optionally redirect to login.
            Response.Write("<script>alert('Registration successful. Please login.');</script>");
        }

        protected void cvPasswordLength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = args.Value.Length >= 8;
        }

        private string ComputeHash(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(input);
                byte[] hash = sha256.ComputeHash(bytes);
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hash)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}
