using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Repository.Interface
{
    public interface ICourseRepository : IRepository<Course, string>
    {
        public Task<List<Professor>> GetProfessorsForCourseAsync(string courseId, int page, int pageSize);
    }
}
