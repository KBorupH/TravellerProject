using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Npgsql;

namespace Admin_website.Pages
{
    public class WorkerPageModel : PageModel
    {
		public void OnGet()
        {
        }
        public void OnPostCreate(string inputNameCreate)
        {
			Model.DataAccess dataAccess = new Model.DataAccess();
			NpgsqlConnection conn = dataAccess.GetConnection();

			using (NpgsqlCommand cmd = new NpgsqlCommand($"CALL NewStaff(add_person('{inputNameCreate}'))", conn))
			{
				//cmd.CommandType = System.Data.CommandType.StoredProcedure;

				try
				{
					conn.Open();
					cmd.ExecuteNonQuery();
					conn.Close();
				}
				catch (Exception)
				{
					throw; // Handles the exception
				}

			}
		}
    }
}
