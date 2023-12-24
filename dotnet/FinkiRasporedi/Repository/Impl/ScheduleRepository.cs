using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository
{
    public class ScheduleRepository : IScheduleRepository
    {
        private readonly DbSet<Schedule> _schedules;
        private readonly ApplicationDbContext _context;
        private readonly ILectureRepository _lectureRepository;

        public ScheduleRepository(ApplicationDbContext context, ILectureRepository lectureRepository)
        {
            _schedules = context.Set<Schedule>();
            _context = context;
            _lectureRepository = lectureRepository;
        }

        public async Task<Schedule> AddAsync(Schedule entity)
        {
            _context.Schedules?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ScheduleExists(entity.Id))
                {
                    throw new ScheduleAlreadyExistsException(entity.Id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        public async Task<Schedule> AddLectureAsync(int id, int lectureId)
        {
            Lecture lecture = await _lectureRepository.GetByIdAsync(lectureId);
            Schedule schedule = await GetByIdAsync(id);
            schedule.Lectures.Add(lecture);
            _context.Entry(schedule).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return schedule;
        }

        public async Task<Schedule?> AddDuplicateLectureAsync(int id, int original_lectureId)
        {
            Lecture lecture = await _lectureRepository.GetByIdAsync(original_lectureId);
            if (lecture.Type == 0)
            {


                Schedule schedule = await GetByIdAsync(id);
                Lecture duplicateLecture = new()
                {
                    Name = lecture.Name,
                    OriginalLecture = lecture,
                    Day = lecture.Day,
                    TimeFrom = lecture.TimeFrom,
                    TimeTo = lecture.TimeTo,
                    Professor = lecture.Professor,
                    Course = lecture.Course,
                    Room = lecture.Room,
                    Type = 1
                };
                Lecture newLecture = await _lectureRepository.AddAsync(duplicateLecture);
                schedule.Lectures.Add(newLecture);
                schedule.Lectures.Remove(lecture);
                _context.Entry(schedule).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                return schedule;
            }
            return null;
        }

        public async Task<Schedule> RemoveLectureAsync(int id, int lectureId)
        {
            Lecture lecture = await _lectureRepository.GetByIdAsync(lectureId);
            Schedule schedule = await GetByIdAsync(id);
            schedule.Lectures.Remove(lecture);
            if (lecture.OriginalLecture != null)
            {
                schedule.Lectures.Add(lecture.OriginalLecture);
            }

            if (lecture.Type == 1 || lecture.Type == 2)
            {
                await _lectureRepository.DeleteAsync(lectureId);
            }
            _context.Entry(schedule).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return schedule;
        }

        public async Task<Schedule> DeleteAsync(int id)
        {
            var schedule = await GetByIdAsync(id);
            _schedules.Remove(schedule);
            await _context.SaveChangesAsync();
            return schedule;
        }

        public async Task<IEnumerable<Schedule>> GetAllAsync()
        {
            return await _schedules.ToListAsync();
        }

        public async Task<Schedule> GetByIdAsync(int id)
        {
            var schedule = await _schedules.FindAsync(id);

            if (schedule == null)
            {
                throw new ScheduleNotFoundException(id);
            }

            return schedule;
        }


        public async Task<IEnumerable<Schedule>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var Schedules = await _schedules
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return Schedules;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _schedules.CountAsync();
        }


        public async Task<Schedule> UpdateAsync(int id, Schedule entity)
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
                if (!ScheduleExists(id))
                {
                    throw new ScheduleNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool ScheduleExists(int id)
        {
            return (_schedules?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
