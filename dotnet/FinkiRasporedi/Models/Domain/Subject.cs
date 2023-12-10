using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Domain
{
    public class Subject
    {
        [Key]
        public string Id { get; set; }
        public string Name { get; set; }
        public int Level { get; set; }
        public string? Abbreviation { get; set; }



    }
}
