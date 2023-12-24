using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Repository.Interface
{
    public interface ILectureRepository : IRepository<Lecture, int>
    {
        Task<List<Lecture>> GetLecturesByCourseAndProfessor(string courseId, string professorId);
    }
}
