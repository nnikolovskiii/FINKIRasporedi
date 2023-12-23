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
        public async Task<ActionResult<IEnumerable<Schedule>>> GetSchedules(int page = 1, int size = 5)
        {
            var schedules = await _scheduleRepository.GetPageAsync(page, size);
            return Ok(schedules);
        }

        // GET: api/Schedules/All
        [HttpGet("All")]
        public async Task<ActionResult<IEnumerable<Schedule>>> GetAllSchedules()
        {
            var schedules = await _scheduleRepository.GetAllAsync();
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

        [HttpPost("addLecture/{id}")]
        public async Task<ActionResult<Schedule>> AddLecture(int id, [FromBody] int lectureId)
        {

            var updatedSchedule = await _scheduleRepository.AddLectureAsync(id, lectureId);
            return Ok(updatedSchedule);
        }

    }
}
