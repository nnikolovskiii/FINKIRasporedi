using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Lecture
    {
        [Key]
        public int Id { get; set; }
        public Day Day { get; set; }
        public TimeSpan TimeFrom { get; set; }
        public TimeSpan TimeTo { get; set; }

        public Professor Professor { get; set; }
        public Course Course { get; set; }
        public Room Room { get; set; }
    }
}
