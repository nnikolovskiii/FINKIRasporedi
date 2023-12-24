using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class lecture_details : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lectures",
                table: "Lectures");

            migrationBuilder.DropIndex(
                name: "IX_Lectures_CourseId",
                table: "Lectures");

            migrationBuilder.DropIndex(
                name: "IX_Lectures_ProfessorId",
                table: "Lectures");

            migrationBuilder.DropIndex(
                name: "IX_Lectures_RoomName",
                table: "Lectures");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CustomLectures",
                table: "CustomLectures");

            migrationBuilder.DropIndex(
                name: "IX_CustomLectures_CourseId",
                table: "CustomLectures");

            migrationBuilder.DropIndex(
                name: "IX_CustomLectures_ProfessorId",
                table: "CustomLectures");

            migrationBuilder.DropIndex(
                name: "IX_CustomLectures_RoomName",
                table: "CustomLectures");

            migrationBuilder.DropColumn(
                name: "CourseId",
                table: "Lectures");

            migrationBuilder.DropColumn(
                name: "Day",
                table: "Lectures");

            migrationBuilder.DropColumn(
                name: "ProfessorId",
                table: "Lectures");

            migrationBuilder.DropColumn(
                name: "RoomName",
                table: "Lectures");

            migrationBuilder.DropColumn(
                name: "TimeFrom",
                table: "Lectures");

            migrationBuilder.DropColumn(
                name: "TimeTo",
                table: "Lectures");

            migrationBuilder.DropColumn(
                name: "CourseId",
                table: "CustomLectures");

            migrationBuilder.DropColumn(
                name: "Day",
                table: "CustomLectures");

            migrationBuilder.DropColumn(
                name: "ProfessorId",
                table: "CustomLectures");

            migrationBuilder.DropColumn(
                name: "RoomName",
                table: "CustomLectures");

            migrationBuilder.DropColumn(
                name: "TimeFrom",
                table: "CustomLectures");

            migrationBuilder.DropColumn(
                name: "TimeTo",
                table: "CustomLectures");

            migrationBuilder.RenameTable(
                name: "Lectures",
                newName: "Lecture");

            migrationBuilder.RenameTable(
                name: "CustomLectures",
                newName: "CustomLecture");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLectures_LectureId",
                table: "CustomLecture",
                newName: "IX_CustomLecture_LectureId");

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

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lecture",
                table: "Lecture",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CustomLecture",
                table: "CustomLecture",
                column: "Id");

            migrationBuilder.CreateTable(
                name: "LectureDetails",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Day = table.Column<int>(type: "int", nullable: false),
                    TimeFrom = table.Column<TimeSpan>(type: "time(6)", nullable: false),
                    TimeTo = table.Column<TimeSpan>(type: "time(6)", nullable: false),
                    ProfessorId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    CourseId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    RoomName = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
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

            migrationBuilder.AddForeignKey(
                name: "FK_CustomLecture_LectureDetails_Id",
                table: "CustomLecture",
                column: "Id",
                principalTable: "LectureDetails",
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
                name: "FK_Lecture_LectureDetails_Id",
                table: "Lecture",
                column: "Id",
                principalTable: "LectureDetails",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ScheduleLectures_LectureDetails_LecturesId",
                table: "ScheduleLectures",
                column: "LecturesId",
                principalTable: "LectureDetails",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_LectureDetails_Id",
                table: "CustomLecture");

            migrationBuilder.DropForeignKey(
                name: "FK_CustomLecture_Lecture_LectureId",
                table: "CustomLecture");

            migrationBuilder.DropForeignKey(
                name: "FK_Lecture_LectureDetails_Id",
                table: "Lecture");

            migrationBuilder.DropForeignKey(
                name: "FK_ScheduleLectures_LectureDetails_LecturesId",
                table: "ScheduleLectures");

            migrationBuilder.DropTable(
                name: "LectureDetails");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lecture",
                table: "Lecture");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CustomLecture",
                table: "CustomLecture");

            migrationBuilder.RenameTable(
                name: "Lecture",
                newName: "Lectures");

            migrationBuilder.RenameTable(
                name: "CustomLecture",
                newName: "CustomLectures");

            migrationBuilder.RenameIndex(
                name: "IX_CustomLecture_LectureId",
                table: "CustomLectures",
                newName: "IX_CustomLectures_LectureId");

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "Lectures",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<string>(
                name: "CourseId",
                table: "Lectures",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<int>(
                name: "Day",
                table: "Lectures",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "ProfessorId",
                table: "Lectures",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "RoomName",
                table: "Lectures",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeFrom",
                table: "Lectures",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeTo",
                table: "Lectures",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "CustomLectures",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<string>(
                name: "CourseId",
                table: "CustomLectures",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<int>(
                name: "Day",
                table: "CustomLectures",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "ProfessorId",
                table: "CustomLectures",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "RoomName",
                table: "CustomLectures",
                type: "varchar(255)",
                nullable: false,
                defaultValue: "")
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeFrom",
                table: "CustomLectures",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeTo",
                table: "CustomLectures",
                type: "time(6)",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lectures",
                table: "Lectures",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CustomLectures",
                table: "CustomLectures",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Lectures_CourseId",
                table: "Lectures",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_Lectures_ProfessorId",
                table: "Lectures",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_Lectures_RoomName",
                table: "Lectures",
                column: "RoomName");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLectures_CourseId",
                table: "CustomLectures",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLectures_ProfessorId",
                table: "CustomLectures",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_CustomLectures_RoomName",
                table: "CustomLectures",
                column: "RoomName");

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
        }
    }
}
