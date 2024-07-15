using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository
{
    public class ProfessorRepository : IProfessorRepository
    {
        private readonly DbSet<Professor> _professors;
        private readonly ApplicationDbContext _context;

        public ProfessorRepository(ApplicationDbContext context)
        {
            _professors = context.Set<Professor>();
            _context = context;
        }

        public async Task<Professor> AddAsync(Professor entity)
        {
            _context.professors?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ProfessorExists(entity.Id))
                {
                    throw new ProfessorAlreadyExistsException(entity.Id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }



        public async Task<Professor> DeleteAsync(string id)
        {
            var professor = await GetByIdAsync(id);
            _professors.Remove(professor);
            await _context.SaveChangesAsync();
            return professor;
        }

        public async Task<IEnumerable<Professor>> GetAllAsync()
        {
            return await _professors.ToListAsync();
        }
        

        public async Task<Professor> GetByIdAsync(string id)
        {
            var professor = await _professors.FindAsync(id);

            if (professor == null)
            {
                throw new ProfessorNotFoundException(id);
            }

            return professor;
        }


        public async Task<IEnumerable<Professor>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var professors = await _professors
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return professors;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _professors.CountAsync();
        }


        public async Task<Professor> UpdateAsync(string id, Professor entity)
        {
            if (id != entity.Id)
            {
                throw new BadRequestIdException();
            }

            _context.Entry(entity).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProfessorExists(id))
                {
                    throw new ProfessorNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool ProfessorExists(string id)
        {
            return (_professors?.Any(e => e.Id == id)).GetValueOrDefault();
        }

    }
}
