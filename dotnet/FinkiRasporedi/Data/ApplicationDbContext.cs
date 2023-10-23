using FinkiRasporedi.Models.Base;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {

        }

        public DbSet<Course>? Courses { get; set; }

        public DbSet<Proffesor>? Proffesors { get; set; }
        public DbSet<Room> Rooms { get; set; }

        public DbSet<Semester> Semesters { get; set; }

        public DbSet<Subject> Subjects { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Course>()
                .HasKey(c => c.Id);
            modelBuilder.Entity<Proffesor>()
                .HasKey(p => p.Id);
            modelBuilder.Entity<Room>()
                .HasKey(r => r.Name);
            modelBuilder.Entity<Semester>()
                .HasKey(s => s.Code);
            modelBuilder.Entity<Subject>()
                .HasKey(s => s.Id);
        }
    }
}