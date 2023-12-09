namespace FinkiRasporedi.Models.Exceptions
{
    public class RoomAlreadyExistsException : Exception
    {
        public RoomAlreadyExistsException(string roomId) : base($"Room with NAME {roomId} already exists.") { }
    }
}
