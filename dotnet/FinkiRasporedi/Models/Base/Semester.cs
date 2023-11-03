using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Semester
    {
        [Key]
        public String Code { get; set; }
        public String? Year { get; set; }

        public SemesterType? SemesterType { get; set; }
        public Subject Subject { get; set; }
    }
}
