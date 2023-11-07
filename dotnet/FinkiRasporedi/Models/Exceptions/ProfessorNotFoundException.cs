namespace FinkiRasporedi.Models.Exceptions
{
    public class ProfessorNotFoundException : Exception
    {
        public ProfessorNotFoundException(string professorId)
            : base($"Professor with ID {professorId} not found")
        {
        }
    }
}
