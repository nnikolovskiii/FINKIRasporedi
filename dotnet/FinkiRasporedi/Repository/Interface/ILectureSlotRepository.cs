using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Repository.Interface
{
    public interface ILectureSlotRepository : IRepository<LectureSlot, int>
    {
        Task<LectureSlot> ResetAsync(int id);
    }
}
