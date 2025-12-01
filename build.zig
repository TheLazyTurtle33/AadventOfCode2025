const std = @import("std");

pub fn build(b: *std.Build) void {
    const day_opt = b.option(u8, "day", "Which Advent of Code day to build (1–25)");
    if (day_opt == null) {
        @panic("You must specify -Dday=N (1–25)");
    }
    const day = day_opt.?;
    if (day < 1 or day > 25) {
        std.debug.print("Invalid day {d}. Must be between 1 and 25.\n", .{day});
        return;
    }

    // Construct folder name: day01, day02, etc.
    var buf: [32]u8 = undefined;
    const folder = std.fmt.bufPrint(&buf, "src/day{d:0>2}", .{day}) catch {
        @panic("format failure");
    };

    const exe = b.addExecutable(.{
        .name = std.fmt.allocPrint(b.allocator, "day{d:0>2}", .{day}) catch @panic("OOM"),
        .root_source_file = b.path(std.fs.path.join(b.allocator, &.{ folder, "main.zig" }) catch @panic("OOM")),

        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the chosen AoC day");
    run_step.dependOn(&run_cmd.step);
}
