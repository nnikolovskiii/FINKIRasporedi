/*using FinkiRasporedi.Data;
using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Service.Impl;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Controllers.Rest
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfessorsController : ControllerBase
    {
        private ProfessorService _professorService;

        public ProfessorsController(ProfessorService professorService)
        {
            _professorService = professorService;
        }

        // GET: api/Professors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Professor>>> GetProfessors(int page = 1, int pageSize = 10)
        {
            var professors = await _professorService.GetProfessorsByPageAsync(page, pageSize);
            return Ok(professors);
        }


        // GET: api/Professors/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Professor>> GetProfessor(string id)
        {
            return await _professorService.GetProfessorAsync(id);
        }

        // PUT: api/Professors/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProfessor(string id, Professor Professor)
        {
            var updatedProfessor = await _professorService.UpdateProfessorAsync(id, Professor);

            if (updatedProfessor == null)
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/Professors
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Professor>> PostProfessor(Professor Professor)
        {
            if (_context.Professors == null)
            {
                return Problem("Entity set 'ApplicationDbContext.Professors'  is null.");
            }
            _context.Professors.Add(Professor);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ProfessorExists(Professor.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetProfessor", new { id = Professor.Id }, Professor);
        }

        // DELETE: api/Professors/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProfessor(string id)
        {
            if (_context.Professors == null)
            {
                return NotFound();
            }
            var Professor = await _context.Professors.FindAsync(id);
            if (Professor == null)
            {
                return NotFound();
            }

            _context.Professors.Remove(Professor);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProfessorExists(string id)
        {
            return (_context.Professors?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
*/