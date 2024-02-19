using FinkiRasporedi.Models.Base;
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

        public Day? Day { get; set; }
        public TimeSpan? TimeFrom { get; set; }
        public TimeSpan? TimeTo { get; set; }


        public String? HexColor { get; set; }

    }
}
