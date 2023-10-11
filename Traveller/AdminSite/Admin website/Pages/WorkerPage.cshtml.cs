using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Npgsql;
using NpgsqlTypes;

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

			using (NpgsqlCommand cmd = new NpgsqlCommand("newperson", conn))
			{
				cmd.CommandType = System.Data.CommandType.StoredProcedure;
				cmd.Parameters.Add(new NpgsqlParameter(inputNameCreate, NpgsqlDbType.Varchar) { Value = "newperson" });


				try
				{
					conn.Open();
					cmd.ExecuteNonQuery();
				}
				                        catch (Exception)
				{
					throw; // Handles the exception
				}
				finally 
				{
					conn.Close(); 
				}
			}
		}
    }
}
