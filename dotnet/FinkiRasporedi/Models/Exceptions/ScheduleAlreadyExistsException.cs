namespace FinkiRasporedi.Models.Exceptions
{
    public class ScheduleAlreadyExistsException : Exception
    {
        public ScheduleAlreadyExistsException(int scheduleId) : base($"Schedule with ID {scheduleId} already exists.") { }
    }
}
