using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Models.Identity;
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
        private readonly ILectureSlotRepository _lectureSlotRepository;
        private readonly DbSet<Student> _students;
        private readonly IAuthRepository _authRepository;


        public ScheduleRepository(
            ApplicationDbContext context,
            ILectureRepository lectureRepository, ILectureSlotRepository lectureSlotRepository,
            IAuthRepository authRepository
        )
        {
            _schedules = context.Set<Schedule>();
            _context = context;
            _lectureRepository = lectureRepository;
            _lectureSlotRepository = lectureSlotRepository;
            _students = context.Set<Student>(); ;
            _authRepository = authRepository;
        }

        public async Task<Schedule> AddAsync(Schedule entity)
        {
            String user_id = _authRepository.ValidateTokenAndGetUserId();
            entity.StudentId = user_id;

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

        public async Task<Schedule> AddLectureAsync(int id, LectureSlot lectureSlot)
        {
            Schedule schedule = await GetByIdAsync(id);

            if (!_authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

            if (lectureSlot.Lecture != null)
            {
                int lectureId = lectureSlot.Lecture.Id;
                Lecture lecture = await _lectureRepository.GetByIdAsync(lectureId);
                lectureSlot.Lecture = lecture;
                lectureSlot.TimeFrom = lecture.TimeFrom;
                lectureSlot.TimeTo = lecture.TimeTo;
                lectureSlot.Name = lecture.Name;
                lectureSlot.Day = lecture.Day;
            }
            LectureSlot tmp = await _lectureSlotRepository.AddAsync(lectureSlot);
            schedule.Lectures.Add(tmp);
            _context.Entry(schedule).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return schedule;
        }


        public async Task<Schedule> RemoveLectureAsync(int id, int lectureSlotId)
        {
            LectureSlot lectureSlot = await _lectureSlotRepository.GetByIdAsync(lectureSlotId);
            await _lectureSlotRepository.DeleteAsync(lectureSlotId);
            Schedule schedule = await GetByIdAsync(id);

            if (!_authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

            schedule.Lectures.Remove(lectureSlot);
            _context.Entry(schedule).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return schedule;
        }

        public async Task<Schedule> DeleteAsync(int id)
        {
            var schedule = await GetByIdAsync(id);

            if (!_authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

            _schedules.Remove(schedule);
            await _context.SaveChangesAsync();
            return schedule;
        }

        public async Task<IEnumerable<Schedule>> GetAllAsync()
        {
            throw new Exception("EndpointNotAccessable");
            return await _schedules.ToListAsync();
        }

        public async Task<Schedule> GetByIdAsync(int id)
        {
            var schedule = await _schedules.FindAsync(id);

            if (!_authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

            if (schedule == null)
            {
                throw new ScheduleNotFoundException(id);
            }

            return schedule;
        }


        public async Task<IEnumerable<Schedule>> GetPageAsync(int page, int pageSize)
        {
            throw new Exception("EndpointNotAccessable");
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
            throw new Exception("EndpointNotAccessable");
            return await _schedules.CountAsync();
        }


        public async Task<Schedule> UpdateAsync(int id, Schedule entity)
        {
            if (!_authRepository.ValidateTokenAndCompareUser(entity.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

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


        public async Task<IEnumerable<Schedule>> GetDefaultSchedules()
        {
            Student? default_user = await _students.FindAsync("FINKI");

            if (default_user != null)
            {
                return default_user.Schedules;
            }

            return Enumerable.Empty<Schedule>();
        }

        public async Task<IEnumerable<Schedule>> GetStudentSchedules()
        {
            var userId = _authRepository.ValidateTokenAndGetUserId();
            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var stuent = await _students.FindAsync(userId);

            if (stuent != null)
            {
                return stuent.Schedules;
            }

            return Enumerable.Empty<Schedule>();
        }
    }
}
