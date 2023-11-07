using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class customLecture : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lectures",
                table: "Lectures");

            migrationBuilder.RenameTable(
                name: "Lectures",
                newName: "Lecture");

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

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lecture",
                table: "Lecture",
                column: "Id");

            migrationBuilder.CreateTable(
                name: "CustomLecture",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Day = table.Column<int>(type: "int", nullable: false),
                    TimeFrom = table.Column<TimeSpan>(type: "time(6)", nullable: false),
                    TimeTo = table.Column<TimeSpan>(type: "time(6)", nullable: false),
                    ProfessorId = table.Column<string>(type: "varchar(255)", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    CourseId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    RoomName = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    LectureId = table.Column<int>(type: "int", nullable: false)
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
                        principalColumn: "Id");
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
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.DropTable(
                name: "CustomLecture");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lecture",
                table: "Lecture");

            migrationBuilder.RenameTable(
                name: "Lecture",
                newName: "Lectures");

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

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lectures",
                table: "Lectures",
                column: "Id");

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
        }
    }
}
