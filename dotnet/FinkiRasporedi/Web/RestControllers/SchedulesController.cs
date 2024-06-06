using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Exceptions;
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

        public SchedulesController(IScheduleRepository ScheduleRepository)
        {
            _scheduleRepository = ScheduleRepository;
        }

        //GET: api/Schedules
        /*[HttpGet]
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
        }*/

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> GetDefaultSchedules(int page, int size)
        {
            try
            {
                var schedules = await _scheduleRepository.GetDefaultSchedules(page, size);
                return Ok(schedules);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
                return StatusCode(500, "Internal server error");
            }
        }

        [HttpGet("myschedules")]
        public async Task<IActionResult> GetStudentSchedules(int page, int size)
        {
            try
            {
                var schedules = await _scheduleRepository.GetStudentSchedules(page, size);
                return Ok(schedules);
            }
            catch (Exception ex)
            {
                return Unauthorized(new { ex.Message });
            }
        }

        // GET: api/schedules/5
        /*   [HttpGet("{id}")]
        public async Task<ActionResult<Schedule>> GetSchedule(int id)
        {
            var schedule = await _scheduleRepository.GetByIdAsync(id);
            return Ok(schedule);
        }*/


        // GET: api/Schedules/5
        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<ActionResult<Schedule>> GetSchedule(int id)
        {
            try
            {
                var schedule = await _scheduleRepository.GetScheduleById(id);
                return Ok(schedule);
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }


        // GET: api/Schedules/5
        [HttpGet("myschedules/{id}")]
        public async Task<ActionResult<Schedule>> GetStudentSchedule(int id)
        {
            try
            {
                var schedule = await _scheduleRepository.GetStudentScheduleById(id);
                return Ok(schedule);
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }

        }

        // PUT: api/Schedules/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("myschedules/{id}")]
        public async Task<IActionResult> EditStudentSchedule(int id, Schedule schedule)
        {
            try
            {
                var updatedSchedule = await _scheduleRepository.EditStudentScheduleAsync(id, schedule);
                return Ok(updatedSchedule);
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
            catch (ScheduleNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (BadRequestIdException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = $"Internal server error: {ex.Message}" });
            }
        }

        // POST: api/Schedules
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Schedule>> PostSchedule(Schedule Schedule)
        {
            var updatedSchedule = await _scheduleRepository.AddAsync(Schedule);
            return Ok(updatedSchedule);
        }

        // DELETE: api/Schedules/myschedules/5
        [HttpDelete("myschedules/{id}")]
        public async Task<IActionResult> DeleteStudentSchedule(int id)
        {
            try
            {
                await _scheduleRepository.DeleteAsync(id);
                return NoContent();
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(ex.Message);
            }
            catch (ScheduleNotFoundException ex)
            {
                return NotFound(ex.Message);
            }
        }

        // POST: api/Schedules/addLecture/5
        [HttpPost("myschedules/addLecture/{id}")]
        public async Task<ActionResult<Schedule?>> AddLecture(int id, LectureSlot lectureSlot)
        {
            try
            {
                var updatedSchedule = await _scheduleRepository.AddLectureAsync(id, lectureSlot); ;
                return Ok(updatedSchedule);
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
            catch (ScheduleNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (BadRequestIdException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = $"Internal server error: {ex.Message}" });
            }
        }


        // DELETE: api/Schedules/removeLecture/5
        [HttpDelete("myschedules/removeLecture/{id}")]
        public async Task<ActionResult<Schedule>> RemoveLectureAsync(int id, [FromBody] int lectureSlotId)
        {
            try
            {
                var updatedSchedule = await _scheduleRepository.RemoveLectureAsync(id, lectureSlotId);
                return Ok(updatedSchedule);
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
            catch (ScheduleNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (BadRequestIdException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = $"Internal server error: {ex.Message}" });
            }

        }
    }
}
