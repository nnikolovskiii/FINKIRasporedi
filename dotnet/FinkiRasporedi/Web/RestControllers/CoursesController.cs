using FinkiRasporedi.Models.Domain;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FinkiRasporedi.Web.RestControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CoursesController : ControllerBase
    {
        private readonly ICourseRepository _courseRepository;

        public CoursesController(ICourseRepository CourseRepository)
        {
            _courseRepository = CourseRepository;
        }

        // GET: api/Courses
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Course>>> GetCourses(int page, int size)
        {
            IEnumerable<Course> courses;

            if (page == 0 && size == 0)
            {
                courses = await _courseRepository.GetAllAsync();

            }
            else
            {
                courses = await _courseRepository.GetPageAsync(page, size);
            }
            return Ok(courses);
        }

        // GET: api/Courses/All
        [HttpGet("All")]
        public async Task<ActionResult<IEnumerable<Course>>> GetAllCourses()
        {
            var courses = await _courseRepository.GetAllAsync();
            return Ok(courses);
        }

        // GET: api/Courses/AllProfessors/5
        [HttpGet("AllProfessors/{id}")]
        public async Task<ActionResult<IEnumerable<Professor>>> GetProfessorsByCourse(string id)
        {
            var professors = await _courseRepository.GetProfessorsForCourseAsync(id);
            return Ok(professors);
        }

        // GET: api/Courses/5
        [HttpGet("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<Course>> GetCourse(string id)
        {
            var course = await _courseRepository.GetByIdAsync(id);
            return Ok(course);
        }

        // PUT: api/Courses/5
        [HttpPut("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> PutCourse(string id, Course course)
        {
            var updatedCourse = await _courseRepository.UpdateAsync(id, course);
            return Ok(updatedCourse);
        }

        // POST: api/Courses
        [HttpPost]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<ActionResult<Course>> PostCourse(Course course)
        {
            var updatedCourse = await _courseRepository.AddAsync(course);
            return Ok(updatedCourse);
        }

        // DELETE: api/Courses/5
        [HttpDelete("{id}")]
        [NonAction]
        [ApiExplorerSettings(IgnoreApi = true)]
        public async Task<IActionResult> DeleteCourse(string id)
        {
            await _courseRepository.DeleteAsync(id);
            return NoContent();
        }
    }
}
