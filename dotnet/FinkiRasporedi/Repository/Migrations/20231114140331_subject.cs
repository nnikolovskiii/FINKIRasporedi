using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class subject : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "SemesterType",
                table: "Subjects",
                newName: "Semester");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Semester",
                table: "Subjects",
                newName: "SemesterType");
        }
    }
}
