using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;


namespace FinkiRasporedi.Models.Domain
{
    public class Room
    {
        [Key]
        public string Name { get; set; }
        [JsonIgnore]
        public virtual  List<Lecture>? Lectures { get; set; }
        [JsonIgnore]
        public int? ScheduleId { get; set; }
        [ForeignKey("ScheduleId")]
        [JsonIgnore]
        public virtual Schedule? Schedule { get; set; }
    }
}
