namespace FinkiRasporedi.Models.Exceptions
{
    public class ProfessorAlreadyExistsException : Exception
    {
        public ProfessorAlreadyExistsException(string professorId)
            : base($"Professor with ID {professorId} already exists.")
        {
        }
    }
}
