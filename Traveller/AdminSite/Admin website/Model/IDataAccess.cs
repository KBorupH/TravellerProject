namespace Admin_website.Model
{
    public interface IDataAccess
    {
        List<string> GetBySubject(string subject);
    }
}
