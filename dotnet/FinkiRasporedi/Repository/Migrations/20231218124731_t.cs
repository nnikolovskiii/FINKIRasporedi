using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class t : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_LectureDetails_Id",
                table: "CustomLecture");

            migrationBuilder.DropForeignKey(
                name: "FK_Lecture_LectureDetails_Id",
                table: "Lecture");

            migrationBuilder.DropTable(
                name: "ScheduleLectures");

            migrationBuilder.DropTable(
                name: "LectureDetails");

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "Lecture",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<string>(
                name: "CourseId",
                table: "Lecture",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<int>(
                name: "Day",
                table: "Lecture",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "ProfessorId",
                table: "Lecture",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "RoomName",
                table: "Lecture",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeFrom",
                table: "Lecture",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeTo",
                table: "Lecture",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "CustomLecture",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<string>(
                name: "CourseId",
                table: "CustomLecture",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<int>(
                name: "Day",
                table: "CustomLecture",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "ProfessorId",
                table: "CustomLecture",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "RoomName",
                table: "CustomLecture",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeFrom",
                table: "CustomLecture",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeTo",
                table: "CustomLecture",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.CreateIndex(
                name: "IX_Lecture_CourseId",
                table: "Lecture",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_Lecture_ProfessorId",
                table: "Lecture",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_Lecture_RoomName",
                table: "Lecture",
                column: "RoomName");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLecture_CourseId",
                table: "CustomLecture",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLecture_ProfessorId",
                table: "CustomLecture",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLecture_RoomName",
                table: "CustomLecture",
                column: "RoomName");

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_Courses_CourseId",
                table: "CustomLecture",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_Professors_ProfessorId",
                table: "CustomLecture",
                column: "ProfessorId",
                principalTable: "Professors",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

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
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_Courses_CourseId",
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

            migrationBuilder.DropIndex(
                name: "IX_Lecture_CourseId",
                table: "Lecture");

            migrationBuilder.DropIndex(
                name: "IX_Lecture_ProfessorId",
                table: "Lecture");

            migrationBuilder.DropIndex(
                name: "IX_Lecture_RoomName",
                table: "Lecture");

            migrationBuilder.DropIndex(
                name: "IX_CustomLecture_CourseId",
                table: "CustomLecture");

            migrationBuilder.DropIndex(
                name: "IX_CustomLecture_ProfessorId",
                table: "CustomLecture");

            migrationBuilder.DropIndex(
                name: "IX_CustomLecture_RoomName",
                table: "CustomLecture");

            migrationBuilder.DropColumn(
                name: "CourseId",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "Day",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "ProfessorId",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "RoomName",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "TimeFrom",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "TimeTo",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "CourseId",
                table: "CustomLecture");

            migrationBuilder.DropColumn(
                name: "Day",
                table: "CustomLecture");

            migrationBuilder.DropColumn(
                name: "ProfessorId",
                table: "CustomLecture");

            migrationBuilder.DropColumn(
                name: "RoomName",
                table: "CustomLecture");

            migrationBuilder.DropColumn(
                name: "TimeFrom",
                table: "CustomLecture");

            migrationBuilder.DropColumn(
                name: "TimeTo",
                table: "CustomLecture");

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "Lecture",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .OldAnnotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "CustomLecture",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .OldAnnotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);

            migrationBuilder.CreateTable(
                name: "LectureDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    CourseId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ProfessorId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    RoomName = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Day = table.Column<int>(type: "int", nullable: false),
                    TimeFrom = table.Column<TimeSpan>(type: "time(6)", nullable: false),
                    TimeTo = table.Column<TimeSpan>(type: "time(6)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LectureDetails", x => x.Id);
                    table.ForeignKey(
                        name: "FK_LectureDetails_Courses_CourseId",
                        column: x => x.CourseId,
                        principalTable: "Courses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_LectureDetails_Professors_ProfessorId",
                        column: x => x.ProfessorId,
                        principalTable: "Professors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_LectureDetails_Rooms_RoomName",
                        column: x => x.RoomName,
                        principalTable: "Rooms",
                        principalColumn: "Name",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

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
                        name: "FK_ScheduleLectures_LectureDetails_LecturesId",
                        column: x => x.LecturesId,
                        principalTable: "LectureDetails",
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
                name: "IX_LectureDetails_CourseId",
                table: "LectureDetails",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_LectureDetails_ProfessorId",
                table: "LectureDetails",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_LectureDetails_RoomName",
                table: "LectureDetails",
                column: "RoomName");

            migrationBuilder.CreateIndex(
                name: "IX_ScheduleLectures_ScheduleId",
                table: "ScheduleLectures",
                column: "ScheduleId");

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_LectureDetails_Id",
                table: "CustomLecture",
                column: "Id",
                principalTable: "LectureDetails",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lecture_LectureDetails_Id",
                table: "Lecture",
                column: "Id",
                principalTable: "LectureDetails",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
