using FinkiRasporedi.Data;
using FinkiRasporedi.Models.Base;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Controllers.Rest
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfessorsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ProfessorsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Professors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Professor>>> GetProfessors()
        {
            if (_context.Professors == null)
            {
                return NotFound();
            }
            return await _context.Professors.ToListAsync();
        }

        // GET: api/Professors/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Professor>> GetProfessor(string id)
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

            return Professor;
        }

        // PUT: api/Professors/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProfessor(string id, Professor Professor)
        {
            if (id != Professor.Id)
            {
                return BadRequest();
            }

            _context.Entry(Professor).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProfessorExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
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
