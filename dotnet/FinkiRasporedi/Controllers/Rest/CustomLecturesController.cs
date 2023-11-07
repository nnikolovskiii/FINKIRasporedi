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
    public class CustomLecturesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public CustomLecturesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/CustomLectures
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CustomLecture>>> GetCustomLecture()
        {
          if (_context.CustomLecture == null)
          {
              return NotFound();
          }
            return await _context.CustomLecture.ToListAsync();
        }

        // GET: api/CustomLectures/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CustomLecture>> GetCustomLecture(int id)
        {
          if (_context.CustomLecture == null)
          {
              return NotFound();
          }
            var customLecture = await _context.CustomLecture.FindAsync(id);

            if (customLecture == null)
            {
                return NotFound();
            }

            return customLecture;
        }

        // PUT: api/CustomLectures/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCustomLecture(int id, CustomLecture customLecture)
        {
            if (id != customLecture.Id)
            {
                return BadRequest();
            }

            _context.Entry(customLecture).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CustomLectureExists(id))
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

        // POST: api/CustomLectures
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CustomLecture>> PostCustomLecture(CustomLecture customLecture)
        {
          if (_context.CustomLecture == null)
          {
              return Problem("Entity set 'ApplicationDbContext.CustomLecture'  is null.");
          }
            _context.CustomLecture.Add(customLecture);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCustomLecture", new { id = customLecture.Id }, customLecture);
        }

        // DELETE: api/CustomLectures/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomLecture(int id)
        {
            if (_context.CustomLecture == null)
            {
                return NotFound();
            }
            var customLecture = await _context.CustomLecture.FindAsync(id);
            if (customLecture == null)
            {
                return NotFound();
            }

            _context.CustomLecture.Remove(customLecture);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CustomLectureExists(int id)
        {
            return (_context.CustomLecture?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
