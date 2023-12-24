using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IScheduleRepository : IRepository<Schedule, int>
    {
        Task<Schedule?> AddDuplicateLectureAsync(int id, int lectureId);
        Task<Schedule> AddLectureAsync(int id, int lectureId);
        Task<Schedule> RemoveLectureAsync(int id, int lectureId);
    }
}
