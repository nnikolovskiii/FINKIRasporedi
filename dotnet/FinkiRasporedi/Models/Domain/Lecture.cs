using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Domain
{
    public class Lecture
    {
        [Key]
        public int Id { get; set; }
        public string? Name { get; set; }
        public Day Day { get; set; }
        public int TimeFrom { get; set; }
        public int TimeTo { get; set; }
        
        public virtual Professor Professor { get; set; }
        public virtual Course Course { get; set; }
        public virtual Room Room { get; set; }
    }
}
