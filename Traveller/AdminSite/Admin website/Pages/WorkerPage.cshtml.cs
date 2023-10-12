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
			DA.DoBySubject(cmd);
		}

		public void OnPostUpdate(string inputuuid, string inputName)
		{
			Model.IDataAccess DA = new Model.DataAccess();
			string cmd = $"CALL UpdateStaffNameById('{inputuuid}','{inputName}')";
			DA.DoBySubject(cmd);
		}
		public void OnPostDelete(string inputuuid)
		{
			Model.IDataAccess DA = new Model.DataAccess();
			string cmd = $"CALL DeleteStaffNameById('{inputuuid}')";
			DA.DoBySubject(cmd);
		}
	}
}
