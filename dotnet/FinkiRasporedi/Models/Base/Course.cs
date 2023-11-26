using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Base
{
    public class Course
    {
        [Key]
        public String Id { get; set; }

        public Semester Semester { get; set; }

        public Subject Subject { get; set; }

    }
}
