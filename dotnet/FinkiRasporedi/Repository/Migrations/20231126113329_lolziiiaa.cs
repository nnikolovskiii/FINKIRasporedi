using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class lolziiiaa : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StudyProgramSubjectProfessors");

            migrationBuilder.DropTable(
                name: "StudyProgramSubjects");

            migrationBuilder.DropTable(
                name: "StudyPrograms");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "Lecture");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "Lecture",
                type: "longtext",
                nullable: false)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "StudyPrograms",
                columns: table => new
                {
                    Code = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Name = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StudyPrograms", x => x.Code);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "StudyProgramSubjects",
                columns: table => new
                {
                    Id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    StudyProgramCode = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    SubjectId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Mandatory = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    Order = table.Column<float>(type: "float", nullable: false),
                    Semester = table.Column<short>(type: "smallint", nullable: false)
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

            migrationBuilder.CreateTable(
                name: "StudyProgramSubjectProfessors",
                columns: table => new
                {
                    Id = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    ProfessorId = table.Column<string>(type: "varchar(255)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    StudyProgramSubjectId = table.Column<string>(type: "varchar(255)", nullable: false)
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

            migrationBuilder.CreateIndex(
                name: "IX_StudyProgramSubjects_StudyProgramCode",
                table: "StudyProgramSubjects",
                column: "StudyProgramCode");

            migrationBuilder.CreateIndex(
                name: "IX_StudyProgramSubjects_SubjectId",
                table: "StudyProgramSubjects",
                column: "SubjectId");
        }
    }
}
