namespace FinkiRasporedi.Models.Exceptions
{
    public class BadRequestIdException:Exception
    {
        public BadRequestIdException(): base("The provided ID in the URL does not match the ID in the entity.")
        {
        }

        public BadRequestIdException(string message) : base(message)
        {
        }

        public BadRequestIdException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}
