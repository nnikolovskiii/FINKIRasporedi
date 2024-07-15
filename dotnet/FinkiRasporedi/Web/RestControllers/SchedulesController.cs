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
    public class SchedulesController(
        IScheduleRepository scheduleRepository,
        IProfessorRepository professorRepository,
        IRoomRepository roomRepository)
        : ControllerBase
    {
        // GET: api/Schedules
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Schedule>>> GetSchedules(int page, int size)
        {
            IEnumerable<Schedule> schedules;
            if (page == 0 && size == 0)
            {
                schedules = await scheduleRepository.GetAllAsync();
            }
            else
            {
                schedules = await scheduleRepository.GetPageAsync(page, size);
            }
            return Ok(schedules);
        }

        // GET: api/Schedules/5
        [HttpGet("{id}")]
        [AllowAnonymous]
        public async Task<ActionResult<Schedule>> GetSchedule(int id)
        {
            var schedule = await scheduleRepository.GetByIdAsync(id);
            return Ok(schedule);
        }

        // PUT: api/Schedules/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSchedule(int id, ScheduleDTO scheduleDto)
        {
            var schedule = new Schedule
            {
                Id = scheduleDto.Id,
                Lectures = scheduleDto.Lectures,
                Description = scheduleDto.Description,
                Name = scheduleDto.Name
            };
            var updatedSchedule = await scheduleRepository.UpdateAsync(id, schedule);
            return Ok(updatedSchedule);
        }

        // POST: api/Schedules
        [HttpPost]
        public async Task<ActionResult<Schedule>> PostSchedule(ScheduleDTO scheduleDto)
        {
            var schedule = new Schedule
            {
                Id = scheduleDto.Id,
                Lectures = scheduleDto.Lectures,
                Description = scheduleDto.Description,
                Name = scheduleDto.Name
            };
            var updatedSchedule = await scheduleRepository.AddAsync(schedule);
            return Ok(updatedSchedule);
        }

        // DELETE: api/Schedules/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSchedule(int id)
        {
            await scheduleRepository.DeleteAsync(id);
            return NoContent();
        }

        // POST: api/Schedules/addLecture/5
        [HttpPost("addLecture/{id}")]
        public async Task<ActionResult<Schedule?>> AddLecture(int id, [FromBody] LectureSlot lectureSlot)
        {
            var updatedSchedule = await scheduleRepository.AddLectureAsync(id, lectureSlot, true);
            return Ok(updatedSchedule);
        }


        // DELETE: api/Schedules/removeLecture/5
        [HttpDelete("removeLecture/{id}")]
        public async Task<ActionResult<Schedule>> RemoveLectureAsync(int id, [FromBody] int lectureId)
        {
            var updatedSchedule = await scheduleRepository.RemoveLectureAsync(id, lectureId);
            return Ok(updatedSchedule);
        }

        // GET: api/Schedules/default
        [AllowAnonymous]
        [HttpGet("default")]
        public async Task<IActionResult> GetDefaultSchedules()
        {
            var schedules = await scheduleRepository.GetDefaultSchedules();
            return Ok(schedules);

        }

        // GET: api/Schedules/student
        [HttpGet("student")]
        public async Task<IActionResult> GetStudentSchedules()
        {
            try
            {
                var schedules = await scheduleRepository.GetStudentSchedules();
                return Ok(schedules);
            }
            catch (Exception)
            {
                return Unauthorized();
            }
        }
        
        [AllowAnonymous]
        [HttpGet("Professor/{id}")]
        public async Task<IActionResult> GetScheduleByProfessor(string id)
        {
            Professor professor = await professorRepository.GetByIdAsync(id);

            if (professor.Schedule == null)
            {
                await scheduleRepository.AddScheduleToProfessor(professor);
            }

            return Ok(professor.Schedule);
        }
        
        [AllowAnonymous]
        [HttpGet("Room/{id}")]
        public async Task<IActionResult> GetScheduleByRoom(string id)
        {
            Room room = await roomRepository.GetByIdAsync(id);

            if (room.Schedule == null)
            {
                await scheduleRepository.AddScheduleToRoom(room);
            }

            return Ok(room.Schedule);
        }
    }
}
