using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SemestersController : ControllerBase
    {
        private readonly ISemesterRepository _semesterRepository;

        public SemestersController(ISemesterRepository semesterRepository)
        {
            _semesterRepository = semesterRepository;
        }

        // GET: api/Semesters
        [HttpGet]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<IEnumerable<Semester>>> GetSemesters(int page, int size)
        {
            IEnumerable<Semester> semesters;
            if (page == 0 && size == 0)
            {
                semesters = await _semesterRepository.GetAllAsync();
            }
            else
            {
                semesters = await _semesterRepository.GetPageAsync(page, size);
            }
            return Ok(semesters);
        }

        // GET: api/Semesters/5
        [HttpGet("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<Semester>> GetSemester(string id)
        {
            var semester = await _semesterRepository.GetByIdAsync(id);
            return Ok(semester);
        }

        // PUT: api/Semesters/5
        [HttpPut("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> PutSemester(string id, Semester semester)
        {
            var updatedSemester = await _semesterRepository.UpdateAsync(id, semester);
            return Ok(updatedSemester);
        }

        // POST: api/Semesters
        [HttpPost]
        public async Task<ActionResult<Semester>> PostSemester(Semester semester)
        {
            var updatedSemester = await _semesterRepository.AddAsync(semester);
            return Ok(updatedSemester);
        }

        // DELETE: api/Semesters/5
        [HttpDelete("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> DeleteSemester(string id)
        {
            await _semesterRepository.DeleteAsync(id);
            return NoContent();
        }

    }
}
