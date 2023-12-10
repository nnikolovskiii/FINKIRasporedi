namespace FinkiRasporedi.Repository
{
    public class CourseAlreadyExistsException : Exception
    {
        public CourseAlreadyExistsException(string courseId)
           : base($"Course with ID {courseId} already exists.")
        {
        }
    }
}