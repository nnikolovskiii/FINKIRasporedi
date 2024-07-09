using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

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
        [JsonIgnore]
        public virtual  List<Lecture> Lectures { get; set; }
        [JsonIgnore]
        public int? ScheduleId { get; set; }
        [ForeignKey("ScheduleId")]
        [JsonIgnore]
        public virtual Schedule? Schedule { get; set; }
    }
}
