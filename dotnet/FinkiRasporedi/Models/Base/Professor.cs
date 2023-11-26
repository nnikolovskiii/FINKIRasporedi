using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Professor
    {
        [Key]
        public String Id { get; set; }
        public String Name { get; set; }
        public String? Email { get; set; }
        public ProfessorTitle? ProfessorTitle { get; set; }
    }
}
