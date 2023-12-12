using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class courseprofessor : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_Courses_CourseId",
                table: "CustomLecture");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_Lecture_LectureId",
                table: "CustomLecture");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_Professors_ProfessorId",
                table: "CustomLecture");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_Rooms_RoomName",
                table: "CustomLecture");

            migrationBuilder.DropForeignKey(
                name: "FK_Lecture_Courses_CourseId",
                table: "Lecture");

            migrationBuilder.DropForeignKey(
                name: "FK_Lecture_Professors_ProfessorId",
                table: "Lecture");

            migrationBuilder.DropForeignKey(
                name: "FK_Lecture_Rooms_RoomName",
                table: "Lecture");

            migrationBuilder.DropForeignKey(
                name: "FK_ScheduleLectures_Lecture_LecturesId",
                table: "ScheduleLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_ScheduleLectures_Schedule_ScheduleId",
                table: "ScheduleLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_StudentSchedules_Schedule_SchedulesId",
                table: "StudentSchedules");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Schedule",
                table: "Schedule");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lecture",
                table: "Lecture");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CustomLecture",
                table: "CustomLecture");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "AspNetUsers");

            migrationBuilder.RenameTable(
                name: "Schedule",
                newName: "Schedules");

            migrationBuilder.RenameTable(
                name: "Lecture",
                newName: "Lectures");

            migrationBuilder.RenameTable(
                name: "CustomLecture",
                newName: "CustomLectures");

            migrationBuilder.RenameIndex(
                name: "IX_Lecture_RoomName",
                table: "Lectures",
                newName: "IX_Lectures_RoomName");

            migrationBuilder.RenameIndex(
                name: "IX_Lecture_ProfessorId",
                table: "Lectures",
                newName: "IX_Lectures_ProfessorId");

            migrationBuilder.RenameIndex(
                name: "IX_Lecture_CourseId",
                table: "Lectures",
                newName: "IX_Lectures_CourseId");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLecture_RoomName",
                table: "CustomLectures",
                newName: "IX_CustomLectures_RoomName");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLecture_ProfessorId",
                table: "CustomLectures",
                newName: "IX_CustomLectures_ProfessorId");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLecture_LectureId",
                table: "CustomLectures",
                newName: "IX_CustomLectures_LectureId");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLecture_CourseId",
                table: "CustomLectures",
                newName: "IX_CustomLectures_CourseId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Schedules",
                table: "Schedules",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lectures",
                table: "Lectures",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CustomLectures",
                table: "CustomLectures",
                column: "Id");

            migrationBuilder.CreateTable(
                name: "CourseProfessors",
                columns: table => new
                {
                    CourseId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ProfessorId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CourseProfessors", x => new { x.CourseId, x.ProfessorId });
                    table.ForeignKey(
                        name: "FK_CourseProfessors_Courses_CourseId",
                        column: x => x.CourseId,
                        principalTable: "Courses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CourseProfessors_Professors_ProfessorId",
                        column: x => x.ProfessorId,
                        principalTable: "Professors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_CourseProfessors_ProfessorId",
                table: "CourseProfessors",
                column: "ProfessorId");

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLectures_Courses_CourseId",
                table: "CustomLectures",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLectures_Lectures_LectureId",
                table: "CustomLectures",
                column: "LectureId",
                principalTable: "Lectures",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLectures_Professors_ProfessorId",
                table: "CustomLectures",
                column: "ProfessorId",
                principalTable: "Professors",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLectures_Rooms_RoomName",
                table: "CustomLectures",
                column: "RoomName",
                principalTable: "Rooms",
                principalColumn: "Name",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lectures_Courses_CourseId",
                table: "Lectures",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lectures_Professors_ProfessorId",
                table: "Lectures",
                column: "ProfessorId",
                principalTable: "Professors",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lectures_Rooms_RoomName",
                table: "Lectures",
                column: "RoomName",
                principalTable: "Rooms",
                principalColumn: "Name",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ScheduleLectures_Lectures_LecturesId",
                table: "ScheduleLectures",
                column: "LecturesId",
                principalTable: "Lectures",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ScheduleLectures_Schedules_ScheduleId",
                table: "ScheduleLectures",
                column: "ScheduleId",
                principalTable: "Schedules",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_StudentSchedules_Schedules_SchedulesId",
                table: "StudentSchedules",
                column: "SchedulesId",
                principalTable: "Schedules",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CustomLectures_Courses_CourseId",
                table: "CustomLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomLectures_Lectures_LectureId",
                table: "CustomLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomLectures_Professors_ProfessorId",
                table: "CustomLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomLectures_Rooms_RoomName",
                table: "CustomLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_Lectures_Courses_CourseId",
                table: "Lectures");

            migrationBuilder.DropForeignKey(
                name: "FK_Lectures_Professors_ProfessorId",
                table: "Lectures");

            migrationBuilder.DropForeignKey(
                name: "FK_Lectures_Rooms_RoomName",
                table: "Lectures");

            migrationBuilder.DropForeignKey(
                name: "FK_ScheduleLectures_Lectures_LecturesId",
                table: "ScheduleLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_ScheduleLectures_Schedules_ScheduleId",
                table: "ScheduleLectures");

            migrationBuilder.DropForeignKey(
                name: "FK_StudentSchedules_Schedules_SchedulesId",
                table: "StudentSchedules");

            migrationBuilder.DropTable(
                name: "CourseProfessors");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Schedules",
                table: "Schedules");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lectures",
                table: "Lectures");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CustomLectures",
                table: "CustomLectures");

            migrationBuilder.RenameTable(
                name: "Schedules",
                newName: "Schedule");

            migrationBuilder.RenameTable(
                name: "Lectures",
                newName: "Lecture");

            migrationBuilder.RenameTable(
                name: "CustomLectures",
                newName: "CustomLecture");

            migrationBuilder.RenameIndex(
                name: "IX_Lectures_RoomName",
                table: "Lecture",
                newName: "IX_Lecture_RoomName");

            migrationBuilder.RenameIndex(
                name: "IX_Lectures_ProfessorId",
                table: "Lecture",
                newName: "IX_Lecture_ProfessorId");

            migrationBuilder.RenameIndex(
                name: "IX_Lectures_CourseId",
                table: "Lecture",
                newName: "IX_Lecture_CourseId");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLectures_RoomName",
                table: "CustomLecture",
                newName: "IX_CustomLecture_RoomName");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLectures_ProfessorId",
                table: "CustomLecture",
                newName: "IX_CustomLecture_ProfessorId");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLectures_LectureId",
                table: "CustomLecture",
                newName: "IX_CustomLecture_LectureId");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLectures_CourseId",
                table: "CustomLecture",
                newName: "IX_CustomLecture_CourseId");

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "AspNetUsers",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Schedule",
                table: "Schedule",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lecture",
                table: "Lecture",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CustomLecture",
                table: "CustomLecture",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_Courses_CourseId",
                table: "CustomLecture",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_Lecture_LectureId",
                table: "CustomLecture",
                column: "LectureId",
                principalTable: "Lecture",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_Professors_ProfessorId",
                table: "CustomLecture",
                column: "ProfessorId",
                principalTable: "Professors",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_Rooms_RoomName",
                table: "CustomLecture",
                column: "RoomName",
                principalTable: "Rooms",
                principalColumn: "Name",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lecture_Courses_CourseId",
                table: "Lecture",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lecture_Professors_ProfessorId",
                table: "Lecture",
                column: "ProfessorId",
                principalTable: "Professors",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lecture_Rooms_RoomName",
                table: "Lecture",
                column: "RoomName",
                principalTable: "Rooms",
                principalColumn: "Name",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ScheduleLectures_Lecture_LecturesId",
                table: "ScheduleLectures",
                column: "LecturesId",
                principalTable: "Lecture",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ScheduleLectures_Schedule_ScheduleId",
                table: "ScheduleLectures",
                column: "ScheduleId",
                principalTable: "Schedule",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_StudentSchedules_Schedule_SchedulesId",
                table: "StudentSchedules",
                column: "SchedulesId",
                principalTable: "Schedule",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
