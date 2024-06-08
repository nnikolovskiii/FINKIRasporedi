using FinkiRasporedi.Models.Identity;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IAuthRepository
    {
        Task<Student> RegisterAsync(StudentRegistrationModel registrationModel);
        Task<Student> LoginAsync(string username, string password);
        string ValidateTokenAndGetUserId();

        string GetTokenFromHeader();

        bool ValidateTokenAndCompareUser(string userId);
    }
}
