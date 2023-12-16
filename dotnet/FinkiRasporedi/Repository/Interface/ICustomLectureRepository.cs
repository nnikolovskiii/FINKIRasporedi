using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Repository.Interface
{
    public interface ICustomLectureRepository : IRepository<CustomLecture, int>
    {
        Task<CustomLecture> AddAsync(int scheduleId, int lectureId);
    }
}
