using FinkiRasporedi.Models.Identity;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Controllers.Rest.Authentication
{
    [ApiController]
    [Route("api/[controller]")]
    public class StudentsController : ControllerBase
    {
        private readonly IStudentRepository _studentRepository;
        private readonly IConfiguration _configuration;

        public StudentsController(IStudentRepository studentRepository, IConfiguration configuration)
        {
            _studentRepository = studentRepository;
            _configuration = configuration;
        }

        [HttpGet("default")]
        public async Task<IActionResult> GetDefaultSchedules(StudentRegistrationModel model)
        {
            var schedules = await _studentRepository.GetDefaultSchedules();
            return Ok(schedules);

        }

    }
}