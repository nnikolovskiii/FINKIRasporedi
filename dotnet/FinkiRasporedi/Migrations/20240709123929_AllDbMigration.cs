using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinkiRasporedi.Migrations
{
    /// <inheritdoc />
    public partial class AllDbMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ScheduleId",
                table: "professors",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Professors_ScheduleId",
                table: "professors",
                column: "ScheduleId");

            migrationBuilder.AddForeignKey(
                name: "FK_Professors_Schedules_ScheduleId",
                table: "professors",
                column: "ScheduleId",
                principalTable: "schedules",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Professors_Schedules_ScheduleId",
                table: "Professors");

            migrationBuilder.DropIndex(
                name: "IX_Professors_ScheduleId",
                table: "Professors");

            migrationBuilder.DropColumn(
                name: "ScheduleId",
                table: "Professors");
        }
    }
}
