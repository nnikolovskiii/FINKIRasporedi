using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Room
    {
        [Key]
        public string Name { get; set; }
    }
}
