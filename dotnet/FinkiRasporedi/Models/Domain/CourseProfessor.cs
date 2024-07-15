using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Models.Domain
{
    public class CourseProfessor
    {
        public virtual Course Course { get; set; }
        public virtual Professor Professor { get; set; }

    }
}
