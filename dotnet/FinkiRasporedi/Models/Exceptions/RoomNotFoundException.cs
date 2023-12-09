namespace FinkiRasporedi.Models.Exceptions
{
    public class RoomNotFoundException : Exception
    {
        public RoomNotFoundException(string roomId) : base($"Room with NAME {roomId} not found") { }
    }
}
