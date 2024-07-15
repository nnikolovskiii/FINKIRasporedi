using FinkiRasporedi.Models.Domain;
using System.ComponentModel.DataAnnotations;

namespace FinkiRasporedi.Models.Domain
{
    public class Course
    {
        [Key]
        public string Id { get; set; }

        public virtual Semester Semester { get; set; }

        public virtual Subject Subject { get; set; }

    }
}
