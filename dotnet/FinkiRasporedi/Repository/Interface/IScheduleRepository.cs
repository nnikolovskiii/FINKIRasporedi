using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IScheduleRepository : IRepository<Schedule, int>
    {
        Task<Schedule> AddLectureAsync(int id, LectureSlot lectureId);
        Task<Schedule> RemoveLectureAsync(int id, int lectureId);
        Task<IEnumerable<Schedule>> GetDefaultSchedules();
        Task<IEnumerable<Schedule>> GetStudentSchedules();
    }
}
