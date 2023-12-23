using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IScheduleRepository : IRepository<Schedule, int>
    {
        Task<Schedule> AddCustomLectureAsync(int id, int lectureId, string name);
        Task<Schedule> AddLectureAsync(int id, int lectureId);
        Task<Schedule> RemoveCustomLectureAsync(int id, int lectureId, string name);
        Task<Schedule> RemoveLectureAsync(int id, int lectureId);
    }
}
