using Microsoft.Data.SqlClient;
using System.Diagnostics;
using System.Text;
using System;
using Npgsql;

namespace Admin_website.Model
{
	public class DataAccess
	{
		// returns connection string for linked database
		public NpgsqlConnection GetConnection()
		{
			return new NpgsqlConnection(@"Server = 192.168.1.128;Port=5432; User Id=DataBaseAdmin;Password=Kode1234!;Database = TravellerDB;");
		}
		public void test()
		{			

			NpgsqlConnection conn = GetConnection();
			conn.Open();

			
			
		}
		
	}
}
