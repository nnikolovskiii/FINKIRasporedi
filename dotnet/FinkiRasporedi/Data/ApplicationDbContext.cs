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

        public DbSet<Professor>? Professors { get; set; }
        public DbSet<Room> Rooms { get; set; }

        public DbSet<Semester> Semesters { get; set; }

        public DbSet<Subject> Subjects { get; set; }

        public DbSet<Lecture> Lectures { get; set; }

        public DbSet<Lecture> CustomLectures { get; set; }

        public DbSet<Schedule> Schedule { get; set; }

        public DbSet<Student> Students { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Course>()
                .HasKey(c => c.Id);
            modelBuilder.Entity<Professor>()
                .HasKey(p => p.Id);
            modelBuilder.Entity<Room>()
                .HasKey(r => r.Name);
            modelBuilder.Entity<Semester>()
                .HasKey(s => s.Code);
            modelBuilder.Entity<Subject>()
                .HasKey(s => s.Id);
            modelBuilder.Entity<Schedule>()
                .HasMany(s => s.Lectures)
                .WithMany()
                .UsingEntity(j => j.ToTable("ScheduleLectures"));
            modelBuilder.Entity<Student>()
               .HasMany(s => s.Schedules)
               .WithMany()
               .UsingEntity(j => j.ToTable("StudentSchedules"));
            modelBuilder.Entity<Lecture>()
               .HasOne(s => s.Professor)
               .WithMany();
            modelBuilder.Entity<Lecture>()
               .HasOne(s => s.Course)
               .WithMany();
            modelBuilder.Entity<Lecture>()
               .HasOne(s => s.Room)
               .WithMany();
            modelBuilder.Entity<CustomLecture>()
                .HasOne(s => s.Lecture);
            modelBuilder.Entity<Course>()
                .HasOne(s => s.Subject);

        }

        public DbSet<FinkiRasporedi.Models.Base.CustomLecture> CustomLecture { get; set; } = default!;
    }
}