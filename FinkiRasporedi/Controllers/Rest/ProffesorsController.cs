using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinkiRasporedi.Data;
using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Controllers.Rest
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProffesorsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ProffesorsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Proffesors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Proffesor>>> GetProffesors()
        {
          if (_context.Proffesors == null)
          {
              return NotFound();
          }
            return await _context.Proffesors.ToListAsync();
        }

        // GET: api/Proffesors/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Proffesor>> GetProffesor(string id)
        {
          if (_context.Proffesors == null)
          {
              return NotFound();
          }
            var proffesor = await _context.Proffesors.FindAsync(id);

            if (proffesor == null)
            {
                return NotFound();
            }

            return proffesor;
        }

        // PUT: api/Proffesors/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProffesor(string id, Proffesor proffesor)
        {
            if (id != proffesor.Id)
            {
                return BadRequest();
            }

            _context.Entry(proffesor).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProffesorExists(id))
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

        // POST: api/Proffesors
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Proffesor>> PostProffesor(Proffesor proffesor)
        {
          if (_context.Proffesors == null)
          {
              return Problem("Entity set 'ApplicationDbContext.Proffesors'  is null.");
          }
            _context.Proffesors.Add(proffesor);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ProffesorExists(proffesor.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetProffesor", new { id = proffesor.Id }, proffesor);
        }

        // DELETE: api/Proffesors/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProffesor(string id)
        {
            if (_context.Proffesors == null)
            {
                return NotFound();
            }
            var proffesor = await _context.Proffesors.FindAsync(id);
            if (proffesor == null)
            {
                return NotFound();
            }

            _context.Proffesors.Remove(proffesor);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProffesorExists(string id)
        {
            return (_context.Proffesors?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
