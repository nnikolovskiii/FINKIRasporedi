using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class new_lecture_config : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CustomLecture");

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "Lecture",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<int>(
                name: "OriginalLectureId",
                table: "Lecture",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Type",
                table: "Lecture",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "ScheduleLectures",
                columns: table => new
                {
                    LecturesId = table.Column<int>(type: "int", nullable: false),
                    ScheduleId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ScheduleLectures", x => new { x.LecturesId, x.ScheduleId });
                    table.ForeignKey(
                        name: "FK_ScheduleLectures_Lecture_LecturesId",
                        column: x => x.LecturesId,
                        principalTable: "Lecture",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ScheduleLectures_Schedules_ScheduleId",
                        column: x => x.ScheduleId,
                        principalTable: "Schedules",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Lecture_OriginalLectureId",
                table: "Lecture",
                column: "OriginalLectureId");

            migrationBuilder.CreateIndex(
                name: "IX_ScheduleLectures_ScheduleId",
                table: "ScheduleLectures",
                column: "ScheduleId");

            migrationBuilder.AddForeignKey(
                name: "FK_Lecture_Lecture_OriginalLectureId",
                table: "Lecture",
                column: "OriginalLectureId",
                principalTable: "Lecture",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Lecture_Lecture_OriginalLectureId",
                table: "Lecture");

            migrationBuilder.DropTable(
                name: "ScheduleLectures");

            migrationBuilder.DropIndex(
                name: "IX_Lecture_OriginalLectureId",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "OriginalLectureId",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "Type",
                table: "Lecture");

            migrationBuilder.CreateTable(
                name: "CustomLecture",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    CourseId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    LectureId = table.Column<int>(type: "int", nullable: false),
                    ProfessorId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    RoomName = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Day = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    TimeFrom = table.Column<TimeSpan>(type: "time(6)", nullable: false),
                    TimeTo = table.Column<TimeSpan>(type: "time(6)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CustomLecture", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CustomLecture_Courses_CourseId",
                        column: x => x.CourseId,
                        principalTable: "Courses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CustomLecture_Lecture_LectureId",
                        column: x => x.LectureId,
                        principalTable: "Lecture",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CustomLecture_Professors_ProfessorId",
                        column: x => x.ProfessorId,
                        principalTable: "Professors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CustomLecture_Rooms_RoomName",
                        column: x => x.RoomName,
                        principalTable: "Rooms",
                        principalColumn: "Name",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLecture_CourseId",
                table: "CustomLecture",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLecture_LectureId",
                table: "CustomLecture",
                column: "LectureId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLecture_ProfessorId",
                table: "CustomLecture",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLecture_RoomName",
                table: "CustomLecture",
                column: "RoomName");
        }
    }
}
