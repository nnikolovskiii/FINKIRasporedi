using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class CreateAbbreviations : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.AddColumn<string>(
                name: "Abbreviation",
                table: "rooms",
                type: "longtext",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.AddColumn<string>(
                name: "Abbreviation",
                table: "lectureslots",
                type: "longtext",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");
            
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.DropColumn(
                name: "Abbreviation",
                table: "rooms");

            migrationBuilder.DropColumn(
                name: "Abbreviation",
                table: "lectureslots");

            migrationBuilder.UpdateData(
                table: "schedules",
                keyColumn: "StudentId",
                keyValue: null,
                column: "StudentId",
                value: "");

        }
    }
}
