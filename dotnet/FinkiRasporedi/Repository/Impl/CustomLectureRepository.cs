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
        private readonly IScheduleRepository _scheduleRepository;
        private readonly ApplicationDbContext _context;

        public CustomLectureRepository(ApplicationDbContext context, IScheduleRepository scheduleRepository)
        {
            _customLectures = context.Set<CustomLecture>();
            _scheduleRepository = scheduleRepository;
            _context = context;
        }

        public async Task<CustomLecture> AddAsync(int scheduleId, int lectureId)
        {
            var schedule = _scheduleRepository.GetByIdAsync(scheduleId);
            var lectures = schedule.Result.Lectures;
            var lecture = lectures.OfType<Lecture>().FirstOrDefault(l => l.Id == lectureId);

            var customLecture = new CustomLecture
            {
                Day = lecture.Day,
                TimeFrom = lecture.TimeFrom,
                TimeTo = lecture.TimeTo,
                Professor = lecture.Professor,
                Course = lecture.Course,
                Room = lecture.Room,
                Lecture = lecture,
            };
            _context.CustomLectures?.Add(customLecture);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CustomLectureExists(customLecture.Id))
                {
                    throw new CustomLectureAlreadyExistsException(customLecture.Id);
                }
                else
                {
                    throw;
                }
            }

            return customLecture;
        }

        public async Task<CustomLecture> AddAsync(CustomLecture customLecture)
        {
            _context.CustomLectures?.Add(customLecture);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CustomLectureExists(customLecture.Id))
                {
                    throw new CustomLectureAlreadyExistsException(customLecture.Id);
                }
                else
                {
                    throw;
                }
            }

            return customLecture;
        }

        public async Task<CustomLecture> DeleteAsync(int id)
        {
            var customLecture = await GetByIdAsync(id);
            _customLectures.Remove(customLecture);
            await _context.SaveChangesAsync();
            return customLecture;
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
