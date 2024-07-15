using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class AddScheduleToRoom : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ScheduleId",
                table: "rooms",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "RoomName1",
                table: "lectures",
                type: "varchar(255)",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_rooms_ScheduleId",
                table: "rooms",
                column: "ScheduleId",
                unique: true);

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

            migrationBuilder.AddForeignKey(
                name: "FK_rooms_schedules_ScheduleId",
                table: "rooms",
                column: "ScheduleId",
                principalTable: "schedules",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_lectures_rooms_RoomName1",
                table: "lectures");

            migrationBuilder.DropForeignKey(
                name: "FK_rooms_schedules_ScheduleId",
                table: "rooms");

            migrationBuilder.DropIndex(
                name: "IX_rooms_ScheduleId",
                table: "rooms");

            migrationBuilder.DropIndex(
                name: "IX_lectures_RoomName1",
                table: "lectures");

            migrationBuilder.DropColumn(
                name: "ScheduleId",
                table: "rooms");

            migrationBuilder.DropColumn(
                name: "RoomName1",
                table: "lectures");
        }
    }
}
