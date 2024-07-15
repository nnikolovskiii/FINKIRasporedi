using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Repository.Interface
{
    public interface ICourseRepository : IRepository<Course, string>
    {
        Task<List<Professor>> GetProfessorsForCourseAsync(string courseId);
    }
}
