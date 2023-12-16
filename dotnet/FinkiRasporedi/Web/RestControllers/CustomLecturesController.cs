using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Controllers.Rest
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomLecturesController : ControllerBase
    {
        private readonly ICustomLectureRepository _customLectureRepository;

        public CustomLecturesController(ICustomLectureRepository CustomLectureRepository)
        {
            _customLectureRepository = CustomLectureRepository;
        }

        // GET: api/CustomLectures
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomLecture>>> GetCustomLectures(int page = 1, int size = 5)
        {
            var customLectures = await _customLectureRepository.GetPageAsync(page, size);
            return Ok(customLectures);
        }

        // GET: api/CustomLectures
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomLecture>>> GetCustomLectures()
        {
            var customLectures = await _customLectureRepository.GetAllAsync();
            return Ok(customLectures);
        }

        // GET: api/CustomLectures/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CustomLecture>> GetCustomLecture(int id)
        {
            var customLecture = await _customLectureRepository.GetByIdAsync(id);
            return Ok(customLecture);
        }

        // PUT: api/CustomLectures/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCustomLecture(int id, CustomLecture customLecture)
        {
            var updatedCustomLecture = await _customLectureRepository.UpdateAsync(id, customLecture);
            return Ok(updatedCustomLecture);
        }

        // POST: api/CustomLectures
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CustomLecture>> PostCustomLecture(CustomLecture customLecture)
        {
            var updatedCustomLecture = await _customLectureRepository.AddAsync(customLecture);
            return Ok(updatedCustomLecture);
        }

        // DELETE: api/CustomLectures/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomLecture(int id)
        {
            await _customLectureRepository.DeleteAsync(id);
            return NoContent();
        }

    }
}
