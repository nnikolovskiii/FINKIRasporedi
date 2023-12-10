namespace FinkiRasporedi.Models.Exceptions
{
    public class CustomLectureNotFoundException : Exception
    {
        public CustomLectureNotFoundException(int customLectureId) : base($"Custom lecture with ID {customLectureId} not found") { }
    }
}
