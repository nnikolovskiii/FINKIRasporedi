using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class StudyProgramSubjectProfessor : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "StudyProgramSubjectProfessors",
                columns: table => new
                {
                    Id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    StudyProgramSubjectId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ProfessorId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Order = table.Column<float>(type: "float", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StudyProgramSubjectProfessors", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StudyProgramSubjectProfessors_Professors_ProfessorId",
                        column: x => x.ProfessorId,
                        principalTable: "Professors",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_StudyProgramSubjectProfessors_StudyProgramSubjects_StudyProg~",
                        column: x => x.StudyProgramSubjectId,
                        principalTable: "StudyProgramSubjects",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_StudyProgramSubjectProfessors_ProfessorId",
                table: "StudyProgramSubjectProfessors",
                column: "ProfessorId");

            migrationBuilder.CreateIndex(
                name: "IX_StudyProgramSubjectProfessors_StudyProgramSubjectId",
                table: "StudyProgramSubjectProfessors",
                column: "StudyProgramSubjectId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StudyProgramSubjectProfessors");
        }
    }
}
