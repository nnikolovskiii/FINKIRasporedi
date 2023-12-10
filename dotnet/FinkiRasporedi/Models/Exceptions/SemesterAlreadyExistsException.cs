namespace FinkiRasporedi.Models.Exceptions
{
    public class SemesterAlreadyExistsException : Exception
    {
        public SemesterAlreadyExistsException(string semesterId) : base($"Semester with CODE {semesterId} already exists.") { }
    }
}
