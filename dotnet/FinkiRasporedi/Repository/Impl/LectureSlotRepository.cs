using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository.Impl
{
    public class LectureSlotRepository : ILectureSlotRepository
    {
        private readonly DbSet<LectureSlot> _lecturesSlots;
        private readonly ApplicationDbContext _context;

        public LectureSlotRepository(ApplicationDbContext context)
        {
            _lecturesSlots = context.Set<LectureSlot>();
            _context = context;
        }

        public async Task<LectureSlot> AddAsync(LectureSlot entity)
        {
            _context.lectureslots?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (LectureSlotExists(entity.Id))
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

        public async Task<LectureSlot> DeleteAsync(int id)
        {
            var lectureSlot = await GetByIdAsync(id);
            _lecturesSlots.Remove(lectureSlot);
            await _context.SaveChangesAsync();
            return lectureSlot;
        }

        public async Task<LectureSlot> GetByIdAsync(int id)
        {
            var lectureSlot = await _lecturesSlots.FindAsync(id);

            if (lectureSlot == null)
            {
                throw new LectureNotFoundException(id);
            }

            return lectureSlot;
        }


        public async Task<IEnumerable<LectureSlot>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var lectureSlots = await _lecturesSlots
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return lectureSlots;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _lecturesSlots.CountAsync();
        }


        public async Task<LectureSlot> UpdateAsync(int id, LectureSlot entity)
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
                if (!LectureSlotExists(id))
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

        public async Task<LectureSlot> ResetAsync(int id)
        {
            LectureSlot entity = await this.GetByIdAsync(id);
            if (entity.Lecture != null)
            {
                entity.TimeFrom = entity.Lecture.TimeFrom;
                entity.TimeTo = entity.Lecture.TimeTo;
                entity.Name = entity.Lecture.Name;
                entity.Day = entity.Lecture.Day;
            }
            _context.Entry(entity).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!LectureSlotExists(id))
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

        private bool LectureSlotExists(int id)
        {
            return (_lecturesSlots?.Any(e => e.Id == id)).GetValueOrDefault();
        }


        public async Task<IEnumerable<LectureSlot>> GetAllAsync()
        {
            return await _lecturesSlots.ToListAsync();
        }
    }
}
