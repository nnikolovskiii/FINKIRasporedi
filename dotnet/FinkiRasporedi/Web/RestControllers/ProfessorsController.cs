using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers
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
        public async Task<ActionResult<IEnumerable<Professor>>> GetProfessors(int page, int size)
        {
            IEnumerable<Professor> professors;
            if (page == 0 && size == 0)
            {
                professors = await _professorRepository.GetAllAsync();
            }
            else
            {
                professors = await _professorRepository.GetPageAsync(page, size);
            }
            return Ok(professors);
        }

        // GET: api/Professors/5
        [HttpGet("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<Professor>> GetProfessor(string id)
        {
            var professor = await _professorRepository.GetByIdAsync(id);
            return Ok(professor);
        }

        // PUT: api/Professors/5
        [HttpPut("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> PutProfessor(string id, Professor professor)
        {
            var updatedProfessor = await _professorRepository.UpdateAsync(id, professor);
            return Ok(updatedProfessor);
        }

        // POST: api/Professors
        [HttpPost]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<Professor>> PostProfessor(Professor professor)
        {
            var updatedProfessor = await _professorRepository.AddAsync(professor);
            return Ok(updatedProfessor);
        }

        // DELETE: api/Professors/5
        [HttpDelete("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> DeleteProfessor(string id)
        {
            await _professorRepository.DeleteAsync(id);
            return NoContent();
        }
    }
}
