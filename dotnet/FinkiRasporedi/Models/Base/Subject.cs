using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Subject
    {
        [Key]
        public String Id { get; set; }
        public String Name { get; set; }
        public int Level { get; set; }
        public String? Abbreviation { get; set; }



    }
}
