using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Domain
{
    public class Room
    {
        [Key]
        public string Name { get; set; }
    }
}
