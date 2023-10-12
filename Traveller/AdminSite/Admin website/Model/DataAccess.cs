using Microsoft.Data.SqlClient;
using System.Diagnostics;
using System.Text;
using System;
using Npgsql;
using NpgsqlTypes;
using System.Data;

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
        public void DoBySubject(string subject)
        {
			Model.DataAccess dataAccess = new Model.DataAccess();
			NpgsqlConnection conn = dataAccess.GetConnection();

			using (NpgsqlCommand cmd = new NpgsqlCommand(subject, conn))
			{
				//cmd.CommandType = System.Data.CommandType.StoredProcedure;

				try
				{
					conn.Open();
					cmd.ExecuteNonQuery();

				}
				catch (Exception)
				{
					throw; // Handles the exception
				}
				finally 
				{
					conn.Close(); 
				}
			}
		}
		public int GetBySubjectCount(string subject) 
		{
			int result = 0;
			NpgsqlConnection conn = GetConnection();

			using (NpgsqlCommand cmd = new NpgsqlCommand(subject, conn))
			{
				try
				{
					conn.Open();
					object countResult = cmd.ExecuteScalar();
                    if (countResult != null && countResult != DBNull.Value)
                    {
                        result = Convert.ToInt32(countResult);
                    }
                }
				catch (Exception)
				{
					throw; // Handles the exception
				}
				finally
				{
					conn.Close();
				}
			}

			return result;
		}
		public List<string> GetListBySubject(string subject)
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
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                result.Add(reader[i].ToString());
                            }
                        }
                    }
                }
				catch (Exception)
				{
					throw; // Handles the exception
				}
				finally
				{
					conn.Close();
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
