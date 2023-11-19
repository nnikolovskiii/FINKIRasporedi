using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class StudyProgramSubject
    {
        [Key]
        public String Id { get; set; }

        public Subject Subject { get; set; }

        public StudyProgram StudyProgram { get; set; }

        public Boolean Mandatory { get; set; }

        public short Semester { get; set; }

        public float Order { get; set; }

    }
}
