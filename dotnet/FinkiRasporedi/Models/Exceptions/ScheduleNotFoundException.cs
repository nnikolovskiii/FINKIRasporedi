namespace FinkiRasporedi.Models.Exceptions
{
    public class ScheduleNotFoundException : Exception
    {
        public ScheduleNotFoundException(int scheduleId) : base($"Schedule with ID {scheduleId} not found") { }
    }
}
