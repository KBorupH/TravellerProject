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
        /// <summary>
        /// Gets the data from the data base from a subject the subject can be a
        /// </summary>
        /// <param name="subject"></param>
        /// <returns></returns>
        public List<string> GetBySubject(string subject)
        {
            List<string> result = new List<string>();
            NpgsqlConnection conn = GetConnection();

            using (NpgsqlCommand cmd = new NpgsqlCommand(subject, conn))
            {
                try
                {
                    conn.Open();
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            if (!reader.IsDBNull(0))
                            {
                                string value = reader.GetString(0);
                                result.Add(value);
                            }
                        }
                    }
                }
                catch (Exception)
                {
                    throw; // Handle the exception according to your application's needs
                }
            }

            return result;
        }
    }
}
