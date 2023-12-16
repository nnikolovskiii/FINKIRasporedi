using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Controllers.Rest
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfessorsController : ControllerBase
    {
        private readonly IProfessorRepository _professorRepository;

        public ProfessorsController(IProfessorRepository professorRepository)
        {
            _professorRepository = professorRepository;
        }

        // GET: api/Professors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Professor>>> GetProfessors(int page = 1, int size = 5)
        {
            var professors = await _professorRepository.GetPageAsync(page, size);
            return Ok(professors);
        }

        // GET: api/Professors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Professor>>> GetProfessors()
        {
            var professors = await _professorRepository.GetAllAsync();
            return Ok(professors);
        }

        // GET: api/Professors/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Professor>> GetProfessor(string id)
        {
            var professor = await _professorRepository.GetByIdAsync(id);
            return Ok(professor);
        }

        // PUT: api/Professors/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProfessor(string id, Professor professor)
        {
            var updatedProfessor = await _professorRepository.UpdateAsync(id, professor);
            return Ok(updatedProfessor);
        }

        // POST: api/Professors
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Professor>> PostProfessor(Professor professor)
        {
            var updatedProfessor = await _professorRepository.AddAsync(professor);
            return Ok(updatedProfessor);
        }

        // DELETE: api/Professors/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProfessor(string id)
        {
            await _professorRepository.DeleteAsync(id);
            return NoContent();
        }

    }
}
