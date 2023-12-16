using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository
{
    public class CustomLectureRepository : ICustomLectureRepository
    {
        private readonly DbSet<CustomLecture> _customLectures;
        private readonly ApplicationDbContext _context;

        public CustomLectureRepository(ApplicationDbContext context)
        {
            _customLectures = context.Set<CustomLecture>();
            _context = context;
        }

        public async Task<CustomLecture> AddAsync(CustomLecture entity)
        {
            _context.CustomLectures?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CustomLectureExists(entity.Id))
                {
                    throw new CustomLectureAlreadyExistsException(entity.Id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }



        public async Task<CustomLecture> DeleteAsync(int id)
        {
            var customLecture = await GetByIdAsync(id);
            _customLectures.Remove(customLecture);
            await _context.SaveChangesAsync();
            return customLecture;
        }

        public async Task<IEnumerable<CustomLecture>> GetAllAsync()
        {
            return await _customLectures.ToListAsync();
        }

        public async Task<CustomLecture> GetByIdAsync(int id)
        {
            var customLecture = await _customLectures.FindAsync(id);

            if (customLecture == null)
            {
                throw new CustomLectureNotFoundException(id);
            }

            return customLecture;
        }


        public async Task<IEnumerable<CustomLecture>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var customLectures = await _customLectures
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return customLectures;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _customLectures.CountAsync();
        }


        public async Task<CustomLecture> UpdateAsync(int id, CustomLecture entity)
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
                if (!CustomLectureExists(id))
                {
                    throw new CustomLectureNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool CustomLectureExists(int id)
        {
            return (_customLectures?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
