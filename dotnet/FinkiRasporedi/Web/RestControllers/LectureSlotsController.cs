using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LecturesSlotsController : ControllerBase
    {
        private readonly ILectureSlotRepository _lectureSlotRepository;

        public LecturesSlotsController(ILectureSlotRepository LectureRepository)
        {
            _lectureSlotRepository = LectureRepository;
        }

        // GET: api/Lectures
        [HttpGet]
        public async Task<ActionResult<IEnumerable<LectureSlot>>> GetLectures(int page, int size)
        {
            IEnumerable<LectureSlot> lectures;
            if (page == 0 && size == 0)
            {
                lectures = await _lectureSlotRepository.GetAllAsync();
            }
            else
            {
                lectures = await _lectureSlotRepository.GetPageAsync(page, size);
            }
            return Ok(lectures);
        }

        // GET: api/Lectures/5
        [HttpGet("{id}")]
        public async Task<ActionResult<LectureSlot>> GetLecture(int id)
        {
            var lecture = await _lectureSlotRepository.GetByIdAsync(id);
            return Ok(lecture);
        }

        // PUT: api/Lectures/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutLecture(int id, LectureSlot Lecture)
        {
            var updatedLecture = await _lectureSlotRepository.UpdateAsync(id, Lecture);
            return Ok(updatedLecture);
        }


        [HttpPut("reset/{id}")]
        public async Task<IActionResult> ResetLecture(int id)
        {
            var updatedLecture = await _lectureSlotRepository.ResetAsync(id);
            return Ok(updatedLecture);
        }

        // POST: api/Lectures
        [HttpPost]
        public async Task<ActionResult<LectureSlot>> PostLecture(LectureSlot Lecture)
        {
            var updatedLecture = await _lectureSlotRepository.AddAsync(Lecture);
            return Ok(updatedLecture);
        }

        // DELETE: api/Lectures/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteLecture(int id)
        {
            await _lectureSlotRepository.DeleteAsync(id);
            return NoContent();
        }

    }
}
