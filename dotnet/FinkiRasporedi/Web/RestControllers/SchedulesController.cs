using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Controllers.Rest
{
    [Route("api/[controller]")]
    [ApiController]
    public class SchedulesController : ControllerBase
    {
        private readonly IScheduleRepository _scheduleRepository;

        public SchedulesController(IScheduleRepository ScheduleRepository)
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
        public async Task<ActionResult<Schedule>> GetSchedule(int id)
        {
            var schedule = await _scheduleRepository.GetByIdAsync(id);
            return Ok(schedule);
        }

        // PUT: api/Schedules/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSchedule(int id, Schedule Schedule)
        {
            var updatedSchedule = await _scheduleRepository.UpdateAsync(id, Schedule);
            return Ok(updatedSchedule);
        }

        // POST: api/Schedules
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Schedule>> PostSchedule(Schedule Schedule)
        {
            var updatedSchedule = await _scheduleRepository.AddAsync(Schedule);
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
        public async Task<ActionResult<Schedule?>> AddLecture(int id, [FromBody] int lectureId)
        {
            var updatedSchedule = await _scheduleRepository.AddLectureAsync(id, lectureId);
            return Ok(updatedSchedule);
        }

        // POST: api/Schedules/addDuplicateLecture/5
        [HttpPost("addDuplicateLecture/{id}")]
        public async Task<ActionResult<Schedule>> AddDuplicateLecture(int id, [FromBody] int lectureId)
        {
            var updatedSchedule = await _scheduleRepository.AddDuplicateLectureAsync(id, lectureId);
            return Ok(updatedSchedule);
        }

        // DELETE: api/Schedules/removeLecture/5
        [HttpDelete("removeLecture/{id}")]
        public async Task<ActionResult<Schedule>> RemoveLectureAsync(int id, [FromBody] int lectureId)
        {
            var updatedSchedule = await _scheduleRepository.RemoveLectureAsync(id, lectureId);
            return Ok(updatedSchedule);
        }
    }
}
