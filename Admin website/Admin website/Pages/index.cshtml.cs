using Admin_website.Model;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Diagnostics;

namespace Admin_website.Pages
{
    public class indexModel : PageModel
    {
        public void OnGet()
        {
        }
		public IActionResult OnPostTest()
		{
			DataAccess DataAccess = new DataAccess();
			DataAccess.test();
			return RedirectToPage("WorkerPage");

		}

	}
}
