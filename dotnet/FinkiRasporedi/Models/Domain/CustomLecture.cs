namespace FinkiRasporedi.Models.Base
{
    public class CustomLecture : LectureDetails
    {
        public string Name { get; set; }
        public virtual Lecture Lecture { get; set; }
    }
}
