using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IScheduleRepository : IRepository<Schedule, int>
    {
        Task<Schedule> AddLectureAsync(int id, LectureSlot lectureId);
        Task<Schedule> RemoveLectureAsync(int id, int lectureId);
        Task<IEnumerable<Schedule>> GetDefaultSchedules(int page, int size);
        Task<IEnumerable<Schedule>> GetStudentSchedules(int page, int size);
        Task<Schedule> GetScheduleById(int id);
        Task<Schedule> GetStudentScheduleById(int id);
        Task<Schedule> DeleteStudentScheduleAsync(int id);
        Task<Schedule> EditStudentScheduleAsync(int id, Schedule schedule);

    }
}
