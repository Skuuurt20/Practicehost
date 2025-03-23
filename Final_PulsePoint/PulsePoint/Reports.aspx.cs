using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Pulsepoint
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure the secretary is logged in; if not, redirect.
            if (!IsPostBack)
            {
                if (Session["SecretaryId"] == null)
                {
                    Response.Redirect("LoginRegister.aspx");
                    return;
                }
                LoadReports();
            }
        }

        private void LoadReports()
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                // Query to group appointments by month, returning total, completed, cancelled
                string query = @"
                    SELECT 
                        DATENAME(MONTH, AppointmentDateTime) AS [Month],
                        COUNT(*) AS TotalAppointments,
                        SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) AS CompletedAppointments,
                        SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS CancelledAppointments
                    FROM Appointments
                    GROUP BY DATENAME(MONTH, AppointmentDateTime), MONTH(AppointmentDateTime)
                    ORDER BY MONTH(AppointmentDateTime)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    // Bind to GridView
                    rptGridView.DataSource = dt;
                    rptGridView.DataBind();

                    // Calculate Key Insights
                    CalculateKeyInsights(dt);
                }
            }
        }

        private void CalculateKeyInsights(DataTable dt)
        {
            if (dt.Rows.Count == 0)
            {
                // If no data, set everything to "N/A" or 0
                lblMaxApptsMonth.Text = "N/A";
                lblMaxCancelledMonth.Text = "N/A";
                lblCompletionPercent.Text = "0%";
                return;
            }

            string maxApptsMonth = "";
            int maxApptsCount = 0;

            string maxCancelledMonth = "";
            int maxCancelledCount = 0;

            int sumTotalAppointments = 0;
            int sumCompletedAppointments = 0;

            foreach (DataRow row in dt.Rows)
            {
                string monthName = row["Month"].ToString();
                int total = Convert.ToInt32(row["TotalAppointments"]);
                int completed = Convert.ToInt32(row["CompletedAppointments"]);
                int cancelled = Convert.ToInt32(row["CancelledAppointments"]);

                // Check for max total appointments
                if (total > maxApptsCount)
                {
                    maxApptsCount = total;
                    maxApptsMonth = monthName;
                }

                // Check for max cancellations
                if (cancelled > maxCancelledCount)
                {
                    maxCancelledCount = cancelled;
                    maxCancelledMonth = monthName;
                }

                sumTotalAppointments += total;
                sumCompletedAppointments += completed;
            }

            // Set label for the month with highest total
            lblMaxApptsMonth.Text = $"{maxApptsMonth}";

            // Set label for the month with most cancellations
            lblMaxCancelledMonth.Text = $"{maxCancelledMonth}";

            // Compute completion percentage
            double completionPercent = 0;
            if (sumTotalAppointments > 0)
            {
                completionPercent = (sumCompletedAppointments / (double)sumTotalAppointments) * 100;
            }
            lblCompletionPercent.Text = $"{completionPercent:F1}%"; // e.g. "87.5%"
        }

        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginRegister.aspx");
        }
    }
}
