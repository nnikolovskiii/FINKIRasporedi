using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Lecture
    {
        [Key]
        public int Id { get; set; }
        public string? Name { get; set; }
        public virtual Lecture? OriginalLecture { get; set; }
        public Day Day { get; set; }
        public TimeSpan TimeFrom { get; set; }
        public TimeSpan TimeTo { get; set; }

        public virtual Professor Professor { get; set; }
        public virtual Course Course { get; set; }
        public virtual Room Room { get; set; }

        public int Type { get; set; }
    }
}
