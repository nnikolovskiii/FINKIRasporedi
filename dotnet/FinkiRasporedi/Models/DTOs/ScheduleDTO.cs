using FinkiRasporedi.Models.Domain;

namespace FinkiRasporedi.Models.Dtos
{
    public class ScheduleDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public virtual List<LectureSlot>? Lectures { get; set; }
    }
    
    //public class Schedule
    // {
    //     [Key]
    //     public int Id { get; set; }
    //     public string Name { get; set; }
    //     public string Description { get; set; }
    //     public virtual List<LectureSlot>? Lectures { get; set; }
    //     [JsonIgnore]
    //     public virtual String StudentId { get; set; }
    // }
}
