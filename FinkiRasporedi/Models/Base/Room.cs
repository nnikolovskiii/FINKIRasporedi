using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Room
    {
        [Key]
        public String Name { get; set; }
    }
}
