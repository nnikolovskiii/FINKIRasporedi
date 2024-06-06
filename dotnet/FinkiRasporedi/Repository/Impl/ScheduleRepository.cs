using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Domain;
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
        private readonly ILectureSlotRepository _lectureSlotRepository;
        private readonly IStudentRepository _studentRepository;

        public ScheduleRepository(ApplicationDbContext context,
            ILectureRepository lectureRepository, ILectureSlotRepository lectureSlotRepository, IStudentRepository studentRepository)
        {
            _schedules = context.Set<Schedule>();
            _context = context;
            _lectureRepository = lectureRepository;
            _lectureSlotRepository = lectureSlotRepository;
            _studentRepository = studentRepository;
        }

        public async Task<IEnumerable<Schedule>> GetDefaultSchedules(int page, int size)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (size < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            try
            {
                var students = await _studentRepository.GetStudentsAsync();
                var default_user = students.FirstOrDefault(z => z.UserName == "FINKI");

                if (default_user != null && default_user.Schedules != null)
                {
                    return default_user.Schedules.Skip((page - 1) * size).Take(size);
                }
                else
                {
                    Console.WriteLine("default_user or default_user.Schedules is null");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
            }

            return Enumerable.Empty<Schedule>();
        }

        public async Task<IEnumerable<Schedule>> GetStudentSchedules(int page, int size)
        {

            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (size < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var token = _studentRepository.GetTokenFromHeader();
            if (token == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var userId = _studentRepository.ValidateTokenAndGetUserId(token);
            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var students = await _studentRepository.GetStudentsAsync();
            var student = students.FirstOrDefault(z => z.Id == userId);

            if (student != null)
            {
                return student.Schedules.Skip((page - 1) * size).Take(size);
            }

            return Enumerable.Empty<Schedule>();
        }

        public async Task<Schedule> GetScheduleById(int id)
        {
            var students = await _studentRepository.GetStudentsAsync();
            var student = students.FirstOrDefault(z => z.UserName == "FINKI");

            if (student != null)
            {
                var schedule = student.Schedules.FirstOrDefault(z => z.Id == id);
                if (schedule == null)
                {
                    throw new ScheduleNotFoundException(id);
                }
                return schedule;
            }

            throw new UnauthorizedAccessException("Invalid token");
        }

        public async Task<Schedule> GetStudentScheduleById(int id)
        {

            var token = _studentRepository.GetTokenFromHeader();
            if (token == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var userId = _studentRepository.ValidateTokenAndGetUserId(token);
            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var students = await _studentRepository.GetStudentsAsync();
            var student = students.FirstOrDefault(z => z.Id == userId);

            if (student != null)
            {
                var schedule = student.Schedules.FirstOrDefault(z => z.Id == id);
                if (schedule == null)
                {
                    throw new ScheduleNotFoundException(id);
                }
                return schedule;
            }

            throw new UnauthorizedAccessException("Invalid token");
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

        public async Task<Schedule> AddLectureAsync(int id, LectureSlot entity)
        {

            var token = _studentRepository.GetTokenFromHeader();
            if (token == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var userId = _studentRepository.ValidateTokenAndGetUserId(token);

            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var students = await _studentRepository.GetStudentsAsync();
            var student = students.FirstOrDefault(z => z.Id == userId);

            if (student == null)
            {
                throw new KeyNotFoundException("Student not found");
            }


            Schedule schedule = GetStudentScheduleById(id).Result;
            if (schedule == null)
            {
                throw new ScheduleNotFoundException(id);
            }

            if (schedule.Id != id)
            {
                throw new BadRequestIdException("Schedule ID mismatch");
            }


            if (entity.Lecture != null)
            {
                int lectureId = entity.Lecture.Id;
                Lecture lecture = await _lectureRepository.GetByIdAsync(lectureId);
                entity.Lecture = lecture;
                entity.TimeFrom = lecture.TimeFrom;
                entity.TimeTo = lecture.TimeTo;
                entity.Name = lecture.Name;
                entity.Day = lecture.Day;
            }
            LectureSlot tmp = await _lectureSlotRepository.AddAsync(entity);
            schedule.Lectures.Add(tmp);
            _context.Entry(schedule).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return schedule;
        }


        public async Task<Schedule> RemoveLectureAsync(int id, int lectureSlotId)
        {

            var token = _studentRepository.GetTokenFromHeader();
            if (token == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var userId = _studentRepository.ValidateTokenAndGetUserId(token);

            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var students = await _studentRepository.GetStudentsAsync();
            var student = students.FirstOrDefault(z => z.Id == userId);

            if (student == null)
            {
                throw new KeyNotFoundException("Student not found");
            }


            Schedule schedule = GetStudentScheduleById(id).Result;
            if (schedule == null)
            {
                throw new ScheduleNotFoundException(id);
            }

            if (schedule.Id != id)
            {
                throw new BadRequestIdException("Schedule ID mismatch");
            }

            LectureSlot lectureSlot = await _lectureSlotRepository.GetByIdAsync(lectureSlotId);
            await _lectureSlotRepository.DeleteAsync(lectureSlotId);
            schedule.Lectures.Remove(lectureSlot);
            _context.Entry(schedule).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return schedule;
        }


        public async Task<Schedule> EditStudentScheduleAsync(int id, Schedule entity)
        {
            var token = _studentRepository.GetTokenFromHeader();
            if (token == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var userId = _studentRepository.ValidateTokenAndGetUserId(token);

            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var students = await _studentRepository.GetStudentsAsync();
            var student = students.FirstOrDefault(z => z.Id == userId);

            if (student == null)
            {
                throw new KeyNotFoundException("Student not found");
            }


            var schedule = student.Schedules.FirstOrDefault(z => z.Id == id);
            if (schedule == null)
            {
                throw new ScheduleNotFoundException(id);
            }

            if (schedule.Id != entity.Id)
            {
                throw new BadRequestIdException("Schedule ID mismatch");
            }

            schedule.Name = entity.Name;
            schedule.Description = entity.Description;
            _context.Entry(schedule).State = EntityState.Modified;

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

        public async Task<Schedule> DeleteStudentScheduleAsync(int id)
        {
            var token = _studentRepository.GetTokenFromHeader();
            if (token == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var userId = _studentRepository.ValidateTokenAndGetUserId(token);
            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var students = await _studentRepository.GetStudentsAsync();
            var student = students.FirstOrDefault(z => z.Id == userId);

            var schedule = student.Schedules.FirstOrDefault(z => z.Id == id);
            if (schedule == null)
            {
                throw new ScheduleNotFoundException(id);
            }

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


        public async Task<Schedule> DeleteAsync(int id)
        {
            var schedule = await GetByIdAsync(id);
            _schedules.Remove(schedule);
            await _context.SaveChangesAsync();
            return schedule;
        }
    }
}
