using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pulsepoint
{
    public partial class LoginRegister : Page
    {
        // Disable unobtrusive validation to use classic ASP.NET validators.
        protected void Page_PreInit(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Optionally set default panel visibility here.
        }

        // Login button click handler
        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string email = txtLoginEmail.Text.Trim();
            string password = txtLoginPassword.Text.Trim();
            string userType = ddlUserType.SelectedValue;

            bool isValid = false;
            int foundId = 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
                {
                    conn.Open();
                    string query = string.Empty;

                    if (userType == "Patient")
                        query = "SELECT PatientId FROM Patients WHERE Email = @Email AND Password = @Password";
                    else if (userType == "Doctor")
                        query = "SELECT DoctorId FROM Doctors WHERE Email = @Email AND Password = @Password";
                    else if (userType == "Secretary")
                        query = "SELECT SecretaryId FROM Secretaries WHERE Email = @Email AND Password = @Password";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password);
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            foundId = Convert.ToInt32(result);
                            isValid = true;
                        }
                    }
                }
            }
            catch (Exception)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while processing your request.');", true);
                return;
            }

            if (isValid)
            {
                if (userType == "Patient")
                {
                    Session["PatientId"] = foundId;
                    Response.Redirect("Patient_Dashboard.aspx");
                }
                else if (userType == "Doctor")
                {
                    Session["DoctorId"] = foundId;
                    Response.Redirect("Doctor_Dashboard.aspx");
                }
                else if (userType == "Secretary")
                {
                    Session["SecretaryId"] = foundId;
                    Response.Redirect("Secretary.aspx");
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid credentials');", true);
            }
        }

        // Register button click handler
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string contactNumber = txtContactNumber.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtRegisterPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (password != confirmPassword)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Passwords do not match.');", true);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
                {
                    conn.Open();
                    string query = @"INSERT INTO Patients (FirstName, LastName, ContactNumber, Email, Password)
                                     VALUES (@FirstName, @LastName, @ContactNumber, @Email, @Password)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", firstName);
                        cmd.Parameters.AddWithValue("@LastName", lastName);
                        cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password); // In production, hash the password.
                        cmd.ExecuteNonQuery();
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Registration successful. Please login.');", true);
            }
            catch (Exception)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred during registration.');", true);
            }
        }
    }
}
