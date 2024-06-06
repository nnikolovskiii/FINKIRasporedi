using FinkiRasporedi.Models.Identity;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IStudentRepository
    {
        Task<IEnumerable<Student>> GetStudentsAsync();
        Task<Student> RegisterAsync(StudentRegistrationModel registrationModel);
        Task<Student> LoginAsync(string username, string password);
        string GetTokenFromHeader();
        string ValidateTokenAndGetUserId(string token);
    }
}
