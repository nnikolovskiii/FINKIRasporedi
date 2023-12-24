using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Controllers.Rest
{
    [Route("api/[controller]")]
    [ApiController]
    public class LecturesController : ControllerBase
    {
        private readonly ILectureRepository _lectureRepository;

        public LecturesController(ILectureRepository LectureRepository)
        {
            _lectureRepository = LectureRepository;
        }

        // GET: api/Lectures
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Lecture>>> GetLectures(string? courseId, string? professorId, int page, int size)
        {
            IEnumerable<Lecture> lectures;
            if (courseId != null && professorId != null)
            {
                lectures = await _lectureRepository.GetLecturesByCourseAndProfessor(courseId, professorId);

            }
            else if (page == 0 && size == 0)
            {
                lectures = await _lectureRepository.GetAllAsync();
            }
            else
            {
                lectures = await _lectureRepository.GetPageAsync(page, size);
            }
            return Ok(lectures);
        }

        // GET: api/Lectures/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Lecture>> GetLecture(int id)
        {
            var lecture = await _lectureRepository.GetByIdAsync(id);
            return Ok(lecture);
        }

        // PUT: api/Lectures/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutLecture(int id, Lecture Lecture)
        {
            var updatedLecture = await _lectureRepository.UpdateAsync(id, Lecture);
            return Ok(updatedLecture);
        }

        // POST: api/Lectures
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Lecture>> PostLecture(Lecture Lecture)
        {
            var updatedLecture = await _lectureRepository.AddAsync(Lecture);
            return Ok(updatedLecture);
        }

        // DELETE: api/Lectures/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteLecture(int id)
        {
            await _lectureRepository.DeleteAsync(id);
            return NoContent();
        }

    }
}
