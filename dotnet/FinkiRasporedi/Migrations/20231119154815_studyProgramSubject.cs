using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class studyProgramSubject : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "StudyProgramSubjects",
                columns: table => new
                {
                    Id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    SubjectId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    StudyProgramCode = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Mandatory = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    Semester = table.Column<short>(type: "smallint", nullable: false),
                    Order = table.Column<float>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StudyProgramSubjects", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StudyProgramSubjects_StudyPrograms_StudyProgramCode",
                        column: x => x.StudyProgramCode,
                        principalTable: "StudyPrograms",
                        principalColumn: "Code",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_StudyProgramSubjects_Subjects_SubjectId",
                        column: x => x.SubjectId,
                        principalTable: "Subjects",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_StudyProgramSubjects_StudyProgramCode",
                table: "StudyProgramSubjects",
                column: "StudyProgramCode");

            migrationBuilder.CreateIndex(
                name: "IX_StudyProgramSubjects_SubjectId",
                table: "StudyProgramSubjects",
                column: "SubjectId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StudyProgramSubjects");
        }
    }
}
