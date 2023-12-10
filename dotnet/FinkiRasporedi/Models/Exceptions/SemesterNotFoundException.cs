namespace FinkiRasporedi.Models.Exceptions
{
    public class SemesterNotFoundException : Exception
    {
        public SemesterNotFoundException(string semesterId) : base($"Semester with ID {semesterId} not found")
        {

        }
    }
}
