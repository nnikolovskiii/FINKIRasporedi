using Microsoft.AspNetCore.Identity;

namespace FinkiRasporedi.Models.Base
{
    public class Student : IdentityUser
    {
        public List<Schedule> Schedules { get; set; }

    }
}
