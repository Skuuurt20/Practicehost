using System;
using System.Data.SqlClient;
using System.Configuration;

namespace PulsePoint
{
    public partial class TestConnection : System.Web.UI.Page
    {
        protected void btnTestConnection_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PulsePointDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    lblResult.CssClass = "message";
                    lblResult.Text = "Connection opened successfully!";
                }
                catch (Exception ex)
                {
                    lblResult.CssClass = "error";
                    lblResult.Text = "Error opening connection: " + ex.Message;
                }
                finally
                {
                    if (con.State == System.Data.ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }
        }
    }
}
