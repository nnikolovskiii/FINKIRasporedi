namespace FinkiRasporedi.Models.Exceptions
{
    public class SubjectNotFoundException : Exception
    {
        public SubjectNotFoundException(string subjectId) : base($"Subject with ID {subjectId} not found") { }
    }
}
