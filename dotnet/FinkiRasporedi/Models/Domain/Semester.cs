using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Domain
{
    public class Semester
    {
        [Key]
        public string Code { get; set; }
        public string? Year { get; set; }

        public SemesterType? SemesterType { get; set; }
    }
}
