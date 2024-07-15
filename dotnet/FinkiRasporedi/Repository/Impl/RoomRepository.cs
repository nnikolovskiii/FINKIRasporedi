using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Exceptions;
using FinkiRasporedi.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository
{
    public class RoomRepository : IRoomRepository
    {
        private readonly DbSet<Room> _rooms;
        private readonly ApplicationDbContext _context;

        public RoomRepository(ApplicationDbContext context)
        {
            _rooms = context.Set<Room>();
            _context = context;
        }

        public async Task<Room> AddAsync(Room entity)
        {
            _context.rooms?.Add(entity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (RoomExists(entity.Name))
                {
                    throw new RoomAlreadyExistsException(entity.Name);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }



        public async Task<Room> DeleteAsync(string id)
        {
            var room = await GetByIdAsync(id);
            _rooms.Remove(room);
            await _context.SaveChangesAsync();
            return room;
        }

        public async Task<IEnumerable<Room>> GetAllAsync()
        {
            return await _rooms.ToListAsync();
        }

        public async Task<Room> GetByIdAsync(string id)
        {
            var room = await _rooms.FindAsync(id);

            if (room == null)
            {
                throw new RoomNotFoundException(id);
            }

            return room;
        }


        public async Task<IEnumerable<Room>> GetPageAsync(int page, int pageSize)
        {
            if (page < 1)
            {
                throw new ArgumentException("Page number must be greater than or equal to 1.");
            }

            if (pageSize < 1)
            {
                throw new ArgumentException("Page size must be greater than or equal to 1.");
            }

            var Rooms = await _rooms
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return Rooms;
        }


        public async Task<int> GetTotalCountAsync()
        {
            return await _rooms.CountAsync();
        }


        public async Task<Room> UpdateAsync(string id, Room entity)
        {
            if (id != entity.Name)
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
                if (!RoomExists(id))
                {
                    throw new RoomNotFoundException(id);
                }
                else
                {
                    throw;
                }
            }

            return entity;
        }

        private bool RoomExists(string id)
        {
            return (_rooms?.Any(e => e.Name == id)).GetValueOrDefault();
        }
    }
}
