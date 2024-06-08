using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Dtos;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]

    public class SchedulesController : ControllerBase
    {
        private readonly IScheduleRepository _scheduleRepository;
        private readonly IAuthRepository _studentRepository;
        public SchedulesController(
            IScheduleRepository ScheduleRepository
        )
        {
            _scheduleRepository = ScheduleRepository;
        }

        // GET: api/Schedules
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Schedule>>> GetSchedules(int page, int size)
        {
            IEnumerable<Schedule> schedules;
            if (page == 0 && size == 0)
            {
                schedules = await _scheduleRepository.GetAllAsync();
            }
            else
            {
                schedules = await _scheduleRepository.GetPageAsync(page, size);
            }
            return Ok(schedules);
        }

        // GET: api/Schedules/5
        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<ActionResult<Schedule>> GetSchedule(int id)
        {
            var schedule = await _scheduleRepository.GetByIdAsync(id);
            return Ok(schedule);
        }

        // PUT: api/Schedules/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSchedule(int id, Schedule Schedule)
        {
            var updatedSchedule = await _scheduleRepository.UpdateAsync(id, Schedule);
            return Ok(updatedSchedule);
        }

        // POST: api/Schedules
        [HttpPost]
        public async Task<ActionResult<Schedule>> PostSchedule(ScheduleDTO scheduleDto)
        {
            Schedule schedule = new Schedule();
            schedule.Id = scheduleDto.Id;
            schedule.Lectures = scheduleDto.Lectures;
            schedule.Description = scheduleDto.Description;
            schedule.Name = scheduleDto.Name;
            var updatedSchedule = await _scheduleRepository.AddAsync(schedule);
            return Ok(updatedSchedule);
        }

        // DELETE: api/Schedules/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSchedule(int id)
        {
            await _scheduleRepository.DeleteAsync(id);
            return NoContent();
        }

        // POST: api/Schedules/addLecture/5
        [HttpPost("addLecture/{id}")]
        public async Task<ActionResult<Schedule?>> AddLecture(int id, [FromBody] LectureSlot lectureSlot)
        {
            var updatedSchedule = await _scheduleRepository.AddLectureAsync(id, lectureSlot);
            return Ok(updatedSchedule);
        }


        // DELETE: api/Schedules/removeLecture/5
        [HttpDelete("removeLecture/{id}")]
        public async Task<ActionResult<Schedule>> RemoveLectureAsync(int id, [FromBody] int lectureId)
        {
            var updatedSchedule = await _scheduleRepository.RemoveLectureAsync(id, lectureId);
            return Ok(updatedSchedule);
        }

        [AllowAnonymous]
        [HttpGet("default")]
        public async Task<IActionResult> GetDefaultSchedules()
        {
            var schedules = await _scheduleRepository.GetDefaultSchedules();
            return Ok(schedules);

        }

        [HttpGet("student")]
        public async Task<IActionResult> GetStudentSchedules()
        {
            try
            {
                var schedules = await _scheduleRepository.GetStudentSchedules();
                return Ok(schedules);
            }
            catch (Exception ex)
            {
                return Unauthorized();
            }
        }
    }
}
