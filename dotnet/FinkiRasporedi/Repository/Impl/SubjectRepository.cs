using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository.Impl
{
    public class SubjectRepository : ISubjectRepository
    {
        private readonly DbSet<Subject> _subjects;
        private readonly ApplicationDbContext _context;

        public SubjectRepository(ApplicationDbContext context)
        {
            _subjects = context.Set<Subject>();
            _context = context;
        }

        public async Task<Subject> AddAsync(Subject entity)
        {
            _context.subjects?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (subjectExists(entity.Id))
                {
                    throw new SubjectAlreadyExistsException(entity.Id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }


        public async Task<Subject> DeleteAsync(string id)
        {
            var subject = await GetByIdAsync(id);
            _subjects.Remove(subject);
            await _context.SaveChangesAsync();
            return subject;
        }

        public async Task<IEnumerable<Subject>> GetAllAsync()
        {
            return await _subjects.ToListAsync();
        }

        public async Task<Subject> GetByIdAsync(string id)
        {
            var subject = await _subjects.FindAsync(id);

            if (subject == null)
            {
                throw new SubjectNotFoundException(id);
            }

            return subject;
        }


        public async Task<IEnumerable<Subject>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var Subject = await _subjects
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return Subject;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _subjects.CountAsync();
        }


        public async Task<Subject> UpdateAsync(string id, Subject entity)
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
                if (!subjectExists(id))
                {
                    throw new SubjectNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool subjectExists(string id)
        {
            return (_subjects?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
