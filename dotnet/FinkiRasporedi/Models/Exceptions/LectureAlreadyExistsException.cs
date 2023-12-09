namespace FinkiRasporedi.Models.Exceptions
{
    public class LectureAlreadyExistsException : Exception
    {
        public LectureAlreadyExistsException(int lectureId) : base($"Lecture with ID {lectureId} already exists.") { }
    }
}
