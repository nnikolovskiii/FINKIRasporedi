using FinkiRasporedi.Models.Base;
using FinkiRasporedi.Models.Identity;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Repository.Impl
{
    public class StudentRepository : IStudentRepository
    {
        private readonly UserManager<Student> _userManager;
        private readonly DbSet<Student> _students;
        private readonly ApplicationDbContext _context;

        public StudentRepository(UserManager<Student> userManager, ApplicationDbContext context)
        {
            _userManager = userManager;
            _students = context.Students;
            _context = context;
        }

        public async Task<Student> RegisterAsync(StudentRegistrationModel registrationModel)
        {
            var student = new Student { UserName = registrationModel.Username, Email = registrationModel.Email };
            var result = await _userManager.CreateAsync(student, registrationModel.Password);
            if (result.Succeeded)
            {
                return student;
            }
            else
            {
                throw new Exception("Failed to register student.");
            }
        }

        public async Task<Student> LoginAsync(string username, string password)
        {
            var user = await _userManager.FindByNameAsync(username);
            if (user != null && await _userManager.CheckPasswordAsync(user, password))
            {
                return user;
            }
            else
            {
                return null;
            }
        }

        public async Task<IEnumerable<Schedule>> GetDefaultSchedules()
        {
            Student? default_user = await _students.FindAsync("FINKI");

            if (default_user != null)
            {
                return default_user.Schedules;
            }

            return Enumerable.Empty<Schedule>();
        }

    }
}
