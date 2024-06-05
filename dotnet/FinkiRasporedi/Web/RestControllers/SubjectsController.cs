using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SubjectsController : ControllerBase
    {
        private readonly ISubjectRepository _subjectRepository;

        public SubjectsController(ISubjectRepository subjectRepository)
        {
            _subjectRepository = subjectRepository;
        }

        // GET: api/Subjects
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Subject>>> GetSubjects(int page, int size)
        {
            IEnumerable<Subject> subjects;
            if (page == 0 && size == 0)
            {
                subjects = await _subjectRepository.GetAllAsync();
            }
            else
            {
                subjects = await _subjectRepository.GetPageAsync(page, size);
            }
            return Ok(subjects);
        }

        // GET: api/Subjects/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Subject>> GetSubject(string id)
        {
            var subject = await _subjectRepository.GetByIdAsync(id);
            return Ok(subject);
        }

        // PUT: api/Subjects/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSubject(string id, Subject subject)
        {
            var updatedSubject = await _subjectRepository.UpdateAsync(id, subject);
            return Ok(updatedSubject);
        }

        // POST: api/Subjects
        [HttpPost]
        public async Task<ActionResult<Subject>> PostSubject(Subject Subject)
        {
            var updatedSubject = await _subjectRepository.AddAsync(Subject);
            return Ok(updatedSubject);
        }

        // DELETE: api/Subjects/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSubjectAsync(string id)
        {
            await _subjectRepository.DeleteAsync(id);
            return NoContent();
        }

    }
}
