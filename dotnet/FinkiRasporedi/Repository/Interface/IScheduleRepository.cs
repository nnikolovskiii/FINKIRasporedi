using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IScheduleRepository : IRepository<Schedule, int>
    {
        Task<IEnumerable<Schedule>> GetDefaultSchedules();
        Task<IEnumerable<Schedule>> GetStudentSchedules();
        Task<Schedule> AddLectureAsync(int id, LectureSlot lectureId, bool valideteUser);
        Task<Schedule> RemoveLectureAsync(int id, int lectureId);
        Task<Professor> AddScheduleToProfessor(Professor professor);
        Task<Room> AddScheduleToRoom(Room room);
    }
}
