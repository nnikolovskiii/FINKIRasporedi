using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Schedule
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public virtual List<Lecture> Lectures { get; set; }
    }
}
