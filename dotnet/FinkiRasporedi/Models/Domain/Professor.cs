using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinkiRasporedi.Models.Domain
{
    public class Professor
    {
        [Key]
        public string Id { get; set; }
        public string Name { get; set; }
        [EmailAddress]
        public string? Email { get; set; }
        public ProfessorTitle? ProfessorTitle { get; set; }
        public virtual  List<Lecture> Lectures { get; set; }
        public int? ScheduleId { get; set; }
        [ForeignKey("ScheduleId")]
        public virtual Schedule? Schedule { get; set; }
    }
}
