using Microsoft.Data.SqlClient;
using System.Text;

namespace Admin_website.Model
{
	//ip adders 10.108.149.14
	public class DataAccess
	{
		// returns connection string for linked database
		public SqlConnection GetConnection()
		{
			return new SqlConnection(@"Data Source = 10.108.149.14,5432; Initial Catalog = Traveller; Trusted_Connection=true; TrustServerCertificate=true;");
		}
		
	}
}
