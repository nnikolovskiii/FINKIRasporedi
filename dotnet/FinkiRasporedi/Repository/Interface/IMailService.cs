using FinkiRasporedi.Models.Mailling;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IMailService
    {
        Task<bool> SendMail(MailData mailData);
    }
}
