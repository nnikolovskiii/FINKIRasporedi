using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class AddLecturesToRoom2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_lectures_rooms_RoomName1",
                table: "lectures");

            migrationBuilder.DropIndex(
                name: "IX_lectures_RoomName1",
                table: "lectures");

            migrationBuilder.DropColumn(
                name: "RoomName1",
                table: "lectures");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "RoomName1",
                table: "lectures",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_lectures_RoomName1",
                table: "lectures",
                column: "RoomName1");

            migrationBuilder.AddForeignKey(
                name: "FK_lectures_rooms_RoomName1",
                table: "lectures",
                column: "RoomName1",
                principalTable: "rooms",
                principalColumn: "Name");
        }
    }
}
