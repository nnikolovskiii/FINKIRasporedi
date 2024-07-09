using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Models.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace FinkiRasporedi.Data
{
    public class ApplicationDbContext : IdentityDbContext<Student>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {

        }

        public DbSet<Course>? courses { get; set; }

        public DbSet<Professor>? professors { get; set; }
        public DbSet<Room> rooms { get; set; }

        public DbSet<Semester> semesters { get; set; }

        public DbSet<Subject> subjects { get; set; }

        public DbSet<Lecture> lectures { get; set; }

        public DbSet<Schedule> schedules { get; set; }

        public DbSet<Student> students { get; set; }

        public DbSet<CourseProfessor> courseprofessors { get; set; }
        public DbSet<LectureSlot> lectureslots { get; set; }


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
                       .UsingEntity(j => j.ToTable("schedulelectures"));
            modelBuilder.Entity<Student>()
               .HasMany(s => s.Schedules)
               .WithOne()
               .HasForeignKey(s => s.StudentId);
            modelBuilder.Entity<Lecture>()
               .HasOne(s => s.Professor)
               .WithMany(p=>p.Lectures)
               .OnDelete(DeleteBehavior.Cascade);
            modelBuilder.Entity<Lecture>()
               .HasOne(s => s.Course)
               .WithMany();
            modelBuilder.Entity<Lecture>()
               .HasOne(s => s.Room)
               .WithMany();
            modelBuilder.Entity<Lecture>()
                .ToTable("lectures");

            modelBuilder.Entity<Course>()
                .HasOne(s => s.Subject);

            modelBuilder.Entity<LectureSlot>()
               .HasOne(s => s.Lecture)
               .WithMany();

            modelBuilder.Entity<LectureSlot>()
               .HasKey(c => c.Id);


            modelBuilder.Entity<LectureSlot>()
               .ToTable("lectureslots");

            modelBuilder.Entity<CourseProfessor>()
               .HasOne(cp => cp.Course)
               .WithMany();
            modelBuilder.Entity<CourseProfessor>()
               .HasOne(cp => cp.Professor)
               .WithMany();
            modelBuilder.Entity<CourseProfessor>()
               .HasKey("CourseId", "ProfessorId");
            modelBuilder.Entity<Professor>()
                .HasOne(p => p.Schedule)
                .WithOne()
                .HasForeignKey<Professor>(p => p.ScheduleId);
            modelBuilder.Entity<Room>()
                .HasOne(r => r.Schedule)
                .WithOne()
                .HasForeignKey<Room>(r => r.ScheduleId);
        }
    }
}