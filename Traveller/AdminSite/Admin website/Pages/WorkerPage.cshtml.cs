using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Admin_website.Pages
{
    public class WorkerPageModel : PageModel
    {
		public string InputText { get; set; }
		public void OnGet()
        {
        }
        public void OnPostTest(string inputText)
        {
			// Access the submitted input
			InputText = inputText;
		}
    }
}
