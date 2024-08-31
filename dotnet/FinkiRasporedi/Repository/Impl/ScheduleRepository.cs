using FinkiRasporedi.Data;
using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Models.Identity;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository.Impl
{
    public class ScheduleRepository(
        ApplicationDbContext context,
        ILectureRepository lectureRepository,
        ILectureSlotRepository lectureSlotRepository,
        IAuthRepository authRepository,
        IProfessorRepository professorRepository,
        IRoomRepository roomRepository)
        : IScheduleRepository
    {
        private readonly DbSet<Schedule> _schedules = context.Set<Schedule>();
        private readonly DbSet<Student> _students = context.Set<Student>();


        public async Task<IEnumerable<Schedule>> GetAllAsync()
        {
            return await _schedules.ToListAsync();
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

            var schedules = await _schedules
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return schedules;
        }

        public async Task<Schedule> GetByIdAsync(int id)
        {
            var schedule = await _schedules.FindAsync(id);
            
            if (schedule == null)
            {
                throw new ScheduleNotFoundException(id);
            }

            if (schedule.StudentId != "FINKI" && schedule.StudentId != "FINKI1" && !authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

            return schedule;
        }

        public async Task<Schedule> AddAsync(Schedule entity)
        {
            String userId = authRepository.ValidateTokenAndGetUserId();
            entity.StudentId = userId;

            return await _addAsync(entity);
        }
        
        private async Task<Schedule> _addAsync(Schedule entity)
        {
            context.schedules.Add(entity);
            try
            {
                await context.SaveChangesAsync();
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
        
        public async Task<Schedule> UpdateAsync(int id, Schedule entity)
        {
            String userId = authRepository.ValidateTokenAndGetUserId();
            entity.StudentId = userId;
   
            if (id != entity.Id)
            {
                throw new BadRequestIdException();
            }

            context.Entry(entity).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
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

        public async Task<Schedule> DeleteAsync(int id)
        {
            var schedule = await GetByIdAsync(id);

            if (!authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

            _schedules.Remove(schedule);
            await context.SaveChangesAsync();
            return schedule;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _schedules.CountAsync();
        }
        

        private bool ScheduleExists(int id)
        {
            return _schedules.Any(e => e.Id == id);
        }


        public async Task<IEnumerable<Schedule>> GetDefaultSchedules()
        {
            Student? defaultUser = await _students.FindAsync("FINKI");

            if (defaultUser != null)
            {
                return defaultUser.Schedules;
            }

            return [];
        }

        public async Task<IEnumerable<Schedule>> GetStudentSchedules()
        {
            var userId = authRepository.ValidateTokenAndGetUserId();
            if (userId == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var student = await _students.FindAsync(userId);

            if (student != null)
            {
                return student.Schedules;
            }
    
            return [];
        }
        
        public async Task<Schedule> AddLectureAsync(int id, LectureSlot lectureSlot, bool validateUser)
        {
            Schedule schedule = await GetByIdAsync(id);

            if (validateUser && !authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }

            if (lectureSlot.Lecture != null)
            {
                int lectureId = lectureSlot.Lecture.Id;
                Lecture lecture = await lectureRepository.GetByIdAsync(lectureId);
                lectureSlot.Lecture = lecture;
                lectureSlot.TimeFrom = lecture.TimeFrom;
                lectureSlot.TimeTo = lecture.TimeTo;
                lectureSlot.Name = lecture.Name;
                lectureSlot.Day = lecture.Day;
                lectureSlot.Abbreviation = lecture.Course.Subject.Abbreviation;
            }
            LectureSlot tmp = await lectureSlotRepository.AddAsync(lectureSlot);
            
            schedule.Lectures ??= new List<LectureSlot>();
            
            schedule.Lectures.Add(tmp);
            context.Entry(schedule).State = EntityState.Modified;
            await context.SaveChangesAsync();
            return schedule;
        }


        public async Task<Schedule> RemoveLectureAsync(int id, int lectureSlotId)
        {
            LectureSlot lectureSlot = await lectureSlotRepository.GetByIdAsync(lectureSlotId);
            await lectureSlotRepository.DeleteAsync(lectureSlotId);
            Schedule schedule = await GetByIdAsync(id);

            if (!authRepository.ValidateTokenAndCompareUser(schedule.StudentId))
            {
                throw new Exception("TokenValidationError");
            }
            
            schedule.Lectures ??= new List<LectureSlot>();
            schedule.Lectures.Remove(lectureSlot);
            context.Entry(schedule).State = EntityState.Modified;
            await context.SaveChangesAsync();
            return schedule;
        }
        
        public async Task<Professor> AddScheduleToProfessor(Professor professor)
        {
            Schedule schedule = new Schedule
            {
                Name = professor.Name,
                Description = professor.Name,
                StudentId = "FINKI1",
                Lectures = new List<LectureSlot>()
            };

            Schedule savedSchedule = await _addAsync(schedule);
            
            foreach (Lecture lecture in professor.Lectures)
            {
                LectureSlot lectureSlot = new LectureSlot
                {
                    Lecture = lecture
                };
                await AddLectureAsync(savedSchedule.Id, lectureSlot, false);
            }

            professor.Schedule = schedule;

            await professorRepository.UpdateAsync(professor.Id, professor);

            return professor;
        }

        public async Task<Room> AddScheduleToRoom(Room room)
        {
            Schedule schedule = new Schedule
            {
                Name = room.Name,
                Description = room.Name,
                StudentId = "FINKI1",
                Lectures = new List<LectureSlot>()
            };

            Schedule savedSchedule = await _addAsync(schedule);
            
            foreach (Lecture lecture in room.Lectures)
            {
                LectureSlot lectureSlot = new LectureSlot
                {
                    Lecture = lecture
                };
                await AddLectureAsync(savedSchedule.Id, lectureSlot, false);
            }

            room.Schedule = schedule;

            await roomRepository.UpdateAsync(room.Name, room);

            return room;
        }
    }
}
