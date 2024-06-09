using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository
{
    public class CourseRepository : ICourseRepository
    {
        private readonly DbSet<Course> _courses;
        private readonly ApplicationDbContext _context;

        public CourseRepository(ApplicationDbContext context)
        {
            _courses = context.Set<Course>();
            _context = context;
        }
        public async Task<Course> AddAsync(Course entity)
        {
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CourseExists(entity.Id))
                {
                    throw new CourseAlreadyExistsException(entity.Id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        public async Task<Course> DeleteAsync(string id)
        {
            var course = await GetByIdAsync(id);
            _courses.Remove(course);
            await _context.SaveChangesAsync();
            return course;
        }

        public async Task<Course> GetByIdAsync(string id)
        {
            var course = await _courses.FindAsync(id);

            if (course == null)
            {
                throw new CourseNotFoundException(id);
            }

            return course;
        }

        public async Task<IEnumerable<Course>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var courses = await _courses
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return courses;
        }

        public async Task<int> GetTotalCountAsync()
        {
            return await _courses.CountAsync();
        }

        public async Task<Course> UpdateAsync(string id, Course entity)
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
                if (!CourseExists(id))
                {
                    throw new CourseNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool CourseExists(string id)
        {
            return (_courses?.Any(e => e.Id == id)).GetValueOrDefault();
        }

        public async Task<List<Professor>> GetProfessorsForCourseAsync(string courseId)
        {
            var query = await _context.courseprofessors
                .Where(courseProfessor => courseProfessor.Course.Id == courseId)
                .Select(courseProfessor => courseProfessor.Professor)
                .ToListAsync();

            return query;
        }

        public async Task<IEnumerable<Course>> GetAllAsync()
        {
            return await _courses.ToListAsync();
        }
    }
}
