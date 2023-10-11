using Npgsql;
using System.Data;
using System.Reflection;
using Admin_website.Model;

public class DatabaseAccess
{
    public DataTable GetDataFromTable(string tableName)
    {
        Admin_website.Model.DataAccess CoolMathGames = new Admin_website.Model.DataAccess();
        NpgsqlConnection connectionString = CoolMathGames.GetConnection();
        {

            connectionString.Open();

                var sqlQuery = $"SELECT * FROM {tableName}";
                using (var command = new NpgsqlCommand(sqlQuery, connectionString))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        var dataTable = new DataTable();
                        dataTable.Load(reader);
                        return dataTable;
                    }
                }
        }
    }
}


   

