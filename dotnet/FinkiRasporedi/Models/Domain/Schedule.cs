using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace FinkiRasporedi.Models.Domain
{
    public class Schedule
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public virtual List<LectureSlot>? Lectures { get; set; }
        [JsonIgnore]
        public virtual String? StudentId { get; set; }
    }
}
