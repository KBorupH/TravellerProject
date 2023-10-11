using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Admin_website.Pages
{
    public class WorkerPageModel : PageModel
    {
		public void OnGet()
        {
        }
        public void OnPostCreate(string inputuuid, string inputName)
        {
			// Access the submitted input
			string InputText = inputuuid;
		}
    }
}
