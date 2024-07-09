using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IScheduleRepository : IRepository<Schedule, int>
    {
        Task<Schedule> AddLectureAsync(int id, LectureSlot lectureId, bool valideteUser);
        Task<Schedule> RemoveLectureAsync(int id, int lectureId);
        Task<IEnumerable<Schedule>> GetDefaultSchedules();
        Task<IEnumerable<Schedule>> GetStudentSchedules();
        Task<Professor> AddScheduleToProfessor(Professor professor);

    }
}
