namespace FinkiRasporedi.Models.Exceptions
{
    public class SubjectAlreadyExistsException : Exception
    {
        public SubjectAlreadyExistsException(string subjectId)
            : base($"Subject with ID {subjectId} already exists.")
        {
        }
    }
}
