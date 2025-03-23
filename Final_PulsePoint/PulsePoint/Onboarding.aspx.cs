using System;
using System.Web.UI;

namespace Pulsepoint
{
    public partial class Onboarding : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Any code to run on page load
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            // This "Sign up" button can redirect to a page with the Register form
            Response.Redirect("LoginRegister.aspx");
        }

        protected void btnGetStarted_Click(object sender, EventArgs e)
        {
            // Also goes to the same page or whichever page you want
            Response.Redirect("LoginRegister.aspx");
        }

        protected void btnDoctor_Click(object sender, EventArgs e)
        {
            // Example: goes to the same "LoginRegister.aspx" (or a specialized Doctor signup page)
            Response.Redirect("LoginRegister.aspx");
        }

        protected void btnPatient_Click(object sender, EventArgs e)
        {
            // For a specialized flow, but currently goes to same page
            Response.Redirect("LoginRegister.aspx");
        }

        protected void btnSecretary_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginRegister.aspx");
        }

        // NEW: The "Login" button in the navbar that goes to a dedicated "Login.aspx"
        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            // If you have a dedicated Login.aspx that shows the login panel by default:
            Response.Redirect("Login.aspx");
        }
    }
}
