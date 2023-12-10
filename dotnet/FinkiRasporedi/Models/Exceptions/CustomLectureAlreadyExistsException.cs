namespace FinkiRasporedi.Models.Exceptions
{
    public class CustomLectureAlreadyExistsException : Exception
    {
        public CustomLectureAlreadyExistsException(int customlectureId) : base($"Custom lecture with ID {customlectureId} already exists.") { }
    }
}
