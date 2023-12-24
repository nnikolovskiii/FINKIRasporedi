using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class new_schedulelecture_model : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ScheduleLectures");

            migrationBuilder.AddColumn<int>(
                name: "ScheduleId",
                table: "Lecture",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "ScheduleLecture",
                columns: table => new
                {
                    ScheduleId = table.Column<int>(type: "int", nullable: false),
                    LectureId = table.Column<int>(type: "int", nullable: false),
                    Color = table.Column<string>(type: "longtext", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ScheduleLecture", x => new { x.ScheduleId, x.LectureId });
                    table.ForeignKey(
                        name: "FK_ScheduleLecture_Lecture_LectureId",
                        column: x => x.LectureId,
                        principalTable: "Lecture",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ScheduleLecture_Schedules_ScheduleId",
                        column: x => x.ScheduleId,
                        principalTable: "Schedules",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_Lecture_ScheduleId",
                table: "Lecture",
                column: "ScheduleId");

            migrationBuilder.CreateIndex(
                name: "IX_ScheduleLecture_LectureId",
                table: "ScheduleLecture",
                column: "LectureId");

            migrationBuilder.AddForeignKey(
                name: "FK_Lecture_Schedules_ScheduleId",
                table: "Lecture",
                column: "ScheduleId",
                principalTable: "Schedules",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Lecture_Schedules_ScheduleId",
                table: "Lecture");

            migrationBuilder.DropTable(
                name: "ScheduleLecture");

            migrationBuilder.DropIndex(
                name: "IX_Lecture_ScheduleId",
                table: "Lecture");

            migrationBuilder.DropColumn(
                name: "ScheduleId",
                table: "Lecture");

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
                name: "IX_ScheduleLectures_ScheduleId",
                table: "ScheduleLectures",
                column: "ScheduleId");
        }
    }
}
