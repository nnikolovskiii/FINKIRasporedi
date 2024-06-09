using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository
{
    public class SemesterRepository : ISemesterRepository
    {
        private readonly DbSet<Semester> _semesters;
        private readonly ApplicationDbContext _context;

        public SemesterRepository(ApplicationDbContext context)
        {
            _semesters = context.Set<Semester>();
            _context = context;
        }

        public async Task<Semester> AddAsync(Semester entity)
        {
            _context.semesters?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SemesterExists(entity.Code))
                {
                    throw new SemesterAlreadyExistsException(entity.Code);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }



        public async Task<Semester> DeleteAsync(string id)
        {
            var Semester = await GetByIdAsync(id);
            _semesters.Remove(Semester);
            await _context.SaveChangesAsync();
            return Semester;
        }

        public async Task<IEnumerable<Semester>> GetAllAsync()
        {
            return await _semesters.ToListAsync();
        }

        public async Task<Semester> GetByIdAsync(string id)
        {
            var semester = await _semesters.FindAsync(id);

            if (semester == null)
            {
                throw new SemesterNotFoundException(id);
            }

            return semester;
        }

        public async Task<IEnumerable<Semester>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var Semesters = await _semesters
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return Semesters;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _semesters.CountAsync();
        }


        public async Task<Semester> UpdateAsync(string id, Semester entity)
        {
            if (id != entity.Code)
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
                if (!SemesterExists(id))
                {
                    throw new SemesterNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool SemesterExists(string id)
        {
            return (_semesters?.Any(e => e.Code == id)).GetValueOrDefault();
        }
    }
}
