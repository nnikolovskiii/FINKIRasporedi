using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Identity;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IStudentRepository
    {
        Task<Student> RegisterAsync(StudentRegistrationModel registrationModel);
        Task<Student> LoginAsync(string username, string password);

        Task<IEnumerable<Schedule>> GetDefaultSchedules();

        Task<IEnumerable<Schedule>> GetStudentSchedules();

    }
}
