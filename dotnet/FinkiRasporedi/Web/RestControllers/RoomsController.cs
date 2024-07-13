﻿using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoomsController : ControllerBase
    {
        private readonly IRoomRepository _roomRepository;

        public RoomsController(IRoomRepository RoomRepository)
        {
            _roomRepository = RoomRepository;
        }

        // GET: api/Rooms
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Room>>> GetRooms(int page, int size)
        {
            IEnumerable<Room> rooms;
            if (page == 0 && size == 0)
            {
                rooms = await _roomRepository.GetAllAsync();
            }
            else
            {
                rooms = await _roomRepository.GetPageAsync(page, size);
            }
            return Ok(rooms);
        }

        // GET: api/Rooms/5
        [HttpGet("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<Room>> GetRoom(string id)
        {
            var room = await _roomRepository.GetByIdAsync(id);
            return Ok(room);
        }

        // PUT: api/Rooms/5
        [HttpPut("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> PutRoom(string id, Room Room)
        {
            var updatedRoom = await _roomRepository.UpdateAsync(id, Room);
            return Ok(updatedRoom);
        }

        // POST: api/Rooms
        [HttpPost]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<Room>> PostRoom(Room Room)
        {
            var updatedRoom = await _roomRepository.AddAsync(Room);
            return Ok(updatedRoom);
        }

        // DELETE: api/Rooms/5
        [HttpDelete("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> DeleteRoom(string id)
        {
            await _roomRepository.DeleteAsync(id);
            return NoContent();
        }
    }
}
