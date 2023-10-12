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
			Model.IDataAccess DA = new Model.DataAccess();
            string cmd = $"CALL NewStaff(add_person('{inputNameCreate}'))";
			DA.GetBySubject(cmd, false);

		}
    }
}
