using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Subject
    {
        [Key]
        public String Id { get; set; }
        public String Name { get; set; }
        public String? Abbreviation { get; set; }
        public int Semester { get; set; }

        public int WeeklyLecturesClasses { get; set; }

        public int WeeklyAuditoriumClasses { get; set; }

        public int WeeklyLabClasses { get; set; }

    }
}
