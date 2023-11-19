using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class StudyProgramSubjectProfessor
    {
        [Key]
        public String Id { get; set; }


        public StudyProgramSubject StudyProgramSubject { get; set; }


        public Professor Professor { get; set; }

        public float Order { get; set; }

    }
}
