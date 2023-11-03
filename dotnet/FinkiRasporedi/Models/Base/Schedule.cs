using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Schedule
    {
        [Key]
        public int Id { get; set; }
        public String Name { get; set; }
        public String Description { get; set; }
        public List<Lecture> Lectures { get; set; }
    }
}
