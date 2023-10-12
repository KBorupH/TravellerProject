namespace Admin_website.Model
{
    public interface IDataAccess
    {
        void DoBySubject(string subject);
        List<string> GetListBySubject(string subject);
        int GetBySubjectCount(string subject);
        Route[] GetAllRoutes();
    }
}
