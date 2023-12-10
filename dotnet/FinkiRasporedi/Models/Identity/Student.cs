using FinkiRasporedi.Models.Base;
using Microsoft.AspNetCore.Identity;

namespace FinkiRasporedi.Models.Identity
{
    public class Student : IdentityUser
    {
        public virtual List<Schedule> Schedules { get; set; }

    }
}
