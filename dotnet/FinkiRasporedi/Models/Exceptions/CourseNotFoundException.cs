namespace FinkiRasporedi.Models.Exceptions
{
    public class CourseNotFoundException : Exception
    {
        public CourseNotFoundException(string courseId)
           : base($"Course with ID {courseId} not found")
        {
        }
    }
}
