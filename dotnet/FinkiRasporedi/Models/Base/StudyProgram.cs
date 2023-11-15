using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class StudyProgram
    {
        [Key]
        public String Code { get; set; }
        public String Name { get; set; }
    }
}
