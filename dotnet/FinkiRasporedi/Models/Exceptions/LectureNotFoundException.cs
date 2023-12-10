namespace FinkiRasporedi.Models.Exceptions
{
    public class LectureNotFoundException : Exception
    {
        public LectureNotFoundException(int lectureId) : base($"Lecture with ID {lectureId} not found") { }
    }
}
