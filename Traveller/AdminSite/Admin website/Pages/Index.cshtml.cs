using Admin_website.Model;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics;
using System.Threading.Tasks;

namespace Admin_website.Pages
{
    public class indexModel : PageModel
    {
        public void OnGet()
        {
        }
		public IActionResult OnPostGoWorkerPage()
		{
			return RedirectToPage("WorkerPage");

		}
	}
}
