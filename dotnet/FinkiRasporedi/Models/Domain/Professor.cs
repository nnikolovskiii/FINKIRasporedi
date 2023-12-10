using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Professor
    {
        [Key]
        public string Id { get; set; }
        public string Name { get; set; }
        [EmailAddress]
        public string? Email { get; set; }
        public ProfessorTitle? ProfessorTitle { get; set; }
    }
}
