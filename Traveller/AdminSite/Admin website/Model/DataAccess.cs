using Microsoft.Data.SqlClient;
using System.Diagnostics;
using System.Text;
using System;
using Npgsql;
using NpgsqlTypes;

namespace Admin_website.Model
{
	public class DataAccess : IDataAccess
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
        public List<string> GetBySubject(string subject, bool isStoredprocedure)
        {
            List<string> result = new List<string>();
            NpgsqlConnection conn = GetConnection();

            using (NpgsqlCommand cmd = new NpgsqlCommand(subject, conn))
            {
				if (isStoredprocedure)
				{
					cmd.CommandType = System.Data.CommandType.StoredProcedure;
				}                
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
                    throw; // Handles the exception
                }
            }

            return result;
        }
		public Route[] GetAllRoutes()
		{
			NpgsqlConnection conn = GetConnection();
			conn.Open();

			//Conn get listviewdestination.

			//map view to objects

			//return list of objects

			Route[] routes = new Route[5] {
				new Route("1", "1", new Station[2]
				{
					new Station("1", "Køge", 4, "12:43"),
					new Station("2", "Ringsted", 3, "14:15"),
				}),
				new Route("1", "1", new Station[2]
				{
					new Station("1", "Køge", 4, "12:43"),
					new Station("2", "Ringsted", 3, "14:15"),
				}),
				new Route("1", "1", new Station[2]
				{
					new Station("1", "Køge", 4, "12:43"),
					new Station("2", "Ringsted", 3, "14:15"),
				}),
				new Route("1", "1", new Station[2]
				{
					new Station("1", "Køge", 4, "12:43"),
					new Station("2", "Ringsted", 3, "14:15"),
				}),
				new Route("1", "1", new Station[2]
				{
					new Station("1", "Køge", 4, "12:43"),
					new Station("2", "Ringsted", 3, "14:15"),
				}),
			};

			return routes;
		}
	}
}
