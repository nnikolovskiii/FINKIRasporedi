using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Models.Domain
{
    public class ScheduleLecture
    {
        public virtual Schedule Schedule { get; set; }
        public virtual Lecture Lecture { get; set; }

        public string? Color { get; set; }
    }
}
