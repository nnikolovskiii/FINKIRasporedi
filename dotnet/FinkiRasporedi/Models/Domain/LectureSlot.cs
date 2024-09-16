using FinkiRasporedi.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Domain
{
    public class LectureSlot
    {

        [Key]
        public int Id { get; set; }

        public virtual Lecture? Lecture { get; set; }

        public String? Name { get; set; }
        
        public String? Abbreviation { get; set; }

        public Day? Day { get; set; }
        public int? TimeFrom { get; set; }
        public int? TimeTo { get; set; }


        public String? HexColor { get; set; }

    }
}
