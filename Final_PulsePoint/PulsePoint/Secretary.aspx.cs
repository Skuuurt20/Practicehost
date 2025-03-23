using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pulsepoint
{
    public partial class Secretary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the secretary is logged in; if not, redirect
                if (Session["SecretaryId"] == null)
                {
                    Response.Redirect("LoginRegister.aspx");
                    return;
                }

                LoadAppointmentStats();
                LoadPatientList(""); // Initially load all patients (no search filter)
            }
        }

        private void LoadAppointmentStats()
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();

                // Count pending
                string pendingQuery = "SELECT COUNT(*) FROM Appointments WHERE Status = 'Pending'";
                using (SqlCommand cmd = new SqlCommand(pendingQuery, conn))
                {
                    int pendingCount = (int)cmd.ExecuteScalar();
                    lblPendingCount.Text = pendingCount.ToString();
                }

                // Count confirmed
                string confirmedQuery = "SELECT COUNT(*) FROM Appointments WHERE Status = 'Confirmed'";
                using (SqlCommand cmd = new SqlCommand(confirmedQuery, conn))
                {
                    int confirmedCount = (int)cmd.ExecuteScalar();
                    lblConfirmedCount.Text = confirmedCount.ToString();
                }

                // Count completed
                string completedQuery = "SELECT COUNT(*) FROM Appointments WHERE Status = 'Completed'";
                using (SqlCommand cmd = new SqlCommand(completedQuery, conn))
                {
                    int completedCount = (int)cmd.ExecuteScalar();
                    lblCompletedCount.Text = completedCount.ToString();
                }
            }
        }

        private void LoadPatientList(string searchName)
        {
            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();

                // Base query
                string query = @"
                    SELECT PatientId, FirstName, LastName, Email, ContactNumber
                    FROM Patients
                ";

                // If user provided a search name, filter by partial match
                if (!string.IsNullOrEmpty(searchName))
                {
                    query += @"
                        WHERE (FirstName + ' ' + LastName LIKE '%' + @SearchName + '%')
                           OR (FirstName LIKE '%' + @SearchName + '%')
                           OR (LastName LIKE '%' + @SearchName + '%')
                    ";
                }

                query += " ORDER BY LastName, FirstName";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchName))
                    {
                        cmd.Parameters.AddWithValue("@SearchName", searchName);
                    }

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvPatients.DataSource = dt;
                    gvPatients.DataBind();
                }
            }
        }

        protected void btnSearchName_Click(object sender, EventArgs e)
        {
            string searchName = txtSearchName.Text.Trim();
            LoadPatientList(searchName);
        }

        // Row Editing
        protected void gvPatients_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPatients.EditIndex = e.NewEditIndex;
            LoadPatientList(txtSearchName.Text.Trim());
        }

        // Row Canceling Edit
        protected void gvPatients_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPatients.EditIndex = -1;
            LoadPatientList(txtSearchName.Text.Trim());
        }

        // Row Updating
        protected void gvPatients_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int patientId = Convert.ToInt32(gvPatients.DataKeys[e.RowIndex].Value);

            // 5th column is "ContactNumber" => index 4 in columns
            GridViewRow row = gvPatients.Rows[e.RowIndex];
            TextBox txtContact = (TextBox)row.Cells[4].Controls[0];
            string newContact = txtContact.Text.Trim();

            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();
                string updateQuery = @"
                    UPDATE Patients
                    SET ContactNumber = @Contact
                    WHERE PatientId = @PatientId
                ";
                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Contact", newContact);
                    cmd.Parameters.AddWithValue("@PatientId", patientId);
                    cmd.ExecuteNonQuery();
                }
            }

            gvPatients.EditIndex = -1;
            LoadPatientList(txtSearchName.Text.Trim());
        }

        // Row Deleting (Delete button only appears in edit mode)
        protected void gvPatients_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the PatientId from the DataKeys
            int patientId = Convert.ToInt32(gvPatients.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(DBHelper.ConnectionString))
            {
                conn.Open();

                // 1) Check if the patient has any appointments
                string checkAppointments = "SELECT COUNT(*) FROM Appointments WHERE PatientId = @PatientId";
                using (SqlCommand cmdCheck = new SqlCommand(checkAppointments, conn))
                {
                    cmdCheck.Parameters.AddWithValue("@PatientId", patientId);
                    int count = (int)cmdCheck.ExecuteScalar();

                    if (count > 0)
                    {
                        // This patient still has appointments => disallow delete
                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "alert",
                            "alert('Cannot delete this patient because they still have existing appointments.');",
                            true
                        );
                        // Cancel the deletion and return
                        return;
                    }
                }

                // 2) If zero appointments => proceed with delete
                string deleteQuery = @"
            DELETE FROM Patients
            WHERE PatientId = @PatientId
        ";
                using (SqlCommand cmdDelete = new SqlCommand(deleteQuery, conn))
                {
                    cmdDelete.Parameters.AddWithValue("@PatientId", patientId);
                    cmdDelete.ExecuteNonQuery();
                }
            }

            // Reset the EditIndex if needed and rebind the GridView
            gvPatients.EditIndex = -1;
            string searchName = txtSearchName.Text.Trim();
            LoadPatientList(searchName);
        }
        protected void logoutbtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginRegister.aspx");
        }
    }
}
