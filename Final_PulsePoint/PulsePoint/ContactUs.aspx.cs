using System;
using System.Web.UI;

namespace Pulsepoint
{
    public partial class ContactUs : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any page load initialization can go here.
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            // For demonstration purposes, simply show a thank you alert.
            // In a production environment, you might insert the contact details into a database
            // or send an email notification.
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Thank you for your message. We will contact you soon.');", true);
        }
    }
}
