using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository
{
    public class LectureRepository : ILectureRepository
    {
        private readonly DbSet<Lecture> _lectures;
        private readonly ApplicationDbContext _context;

        public LectureRepository(ApplicationDbContext context)
        {
            _lectures = context.Set<Lecture>();
            _context = context;
        }

        public async Task<Lecture> AddAsync(Lecture entity)
        {
            _context.Lectures?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (LectureExists(entity.Id))
                {
                    throw new LectureAlreadyExistsException(entity.Id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }



        public async Task<Lecture> DeleteAsync(int id)
        {
            var lecture = await GetByIdAsync(id);
            _lectures.Remove(lecture);
            await _context.SaveChangesAsync();
            return lecture;
        }

        public async Task<Lecture> GetByIdAsync(int id)
        {
            var lecture = await _lectures.FindAsync(id);

            if (lecture == null)
            {
                throw new LectureNotFoundException(id);
            }

            return lecture;
        }


        public async Task<IEnumerable<Lecture>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var lectures = await _lectures
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return lectures;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _lectures.CountAsync();
        }


        public async Task<Lecture> UpdateAsync(int id, Lecture entity)
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
                if (!LectureExists(id))
                {
                    throw new LectureNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool LectureExists(int id)
        {
            return (_lectures?.Any(e => e.Id == id)).GetValueOrDefault();
        }


        public async Task<List<Lecture>> GetLecturesByCourseAndProfessor(string courseId, string professorId, int page, int pageSize)
        {
            return await _lectures
                .Where(lecture => lecture.Course.Id == courseId && lecture.Professor.Id == professorId)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
        }

        public async Task<IEnumerable<Lecture>> GetAllAsync()
        {
            return await _lectures.ToListAsync();
        }
    }
}
