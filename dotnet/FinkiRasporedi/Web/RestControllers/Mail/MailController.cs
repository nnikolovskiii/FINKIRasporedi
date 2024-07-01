using FinkiRasporedi.Models.Mailling;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers.Mail
{
    [Route("[controller]")]
    [ApiController]
    public class MailController : ControllerBase
    {
        private readonly IMailService _mailService;

        public MailController(IMailService mailService)
        {
            _mailService = mailService;
        }

        [HttpPost]
        [Route("SendMail")]
        public async Task<IActionResult> SendMail(MailData mailData)
        {
            bool result = await _mailService.SendMail(mailData);

            if (result)
            {
                return Ok("Email sent successfully.");
            }
            else
            {
                return StatusCode(500, "Failed to send email.");
            }
        }
    }
}
