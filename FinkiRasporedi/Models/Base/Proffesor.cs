using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Proffesor
    {
        [Key]
        public String Id { get; set; }
        public String Name { get; set; }
        public String Email { get; set; }
        public ProffesorTitle ProffesorTitle { get; set; }
    }
}
