const std = @import("std");

const dial = struct {
    position: i32 = 0,
    max: i32 = 99,

    fn turn(self: *dial, r: i32, right: bool) struct { i32, bool } {
        var count: i32 = 0;
        var rotation = r;
        while (rotation >= self.max + 1) {
            rotation -= self.max + 1;
            count += 1;
        }
        if (right) {
            self.position += rotation;
            if (self.position >= self.max + 1) {
                self.position -= self.max + 1;
                count += 1;
            }
        } else {
            if (rotation > self.position) {
                self.position += 100;
                count += 1;
            }
            self.position -= rotation;
        }

        return .{ count, self.position == 0 };
    }
    fn turnBrute(self: *dial, r: i32, right: bool) i32 {
        var ro = r;
        var count: i32 = 0;
        while (ro > 0) {
            if (right) {
                self.position += 1;
                if (self.position >= self.max + 1) {
                    self.position = 0;
                }
            } else {
                self.position -= 1;
                if (self.position <= -1) {
                    self.position = self.max;
                }
            }
            if (self.position == 0) {
                count += 1;
            }
            ro -= 1;
        }
        return count;
    }
};

pub fn main() !void {
    std.debug.print("Advent of Code - Day 1\n", .{});

    const input = @embedFile("input.txt");
    // std.debug.print("Embedded text:\n{s}\n", .{input});
    var lines = std.mem.split(u8, input, "\n");

    var safe: dial = .{ .position = 50 };
    var brute: dial = .{ .position = 50 };
    var onZeroCount: i32 = 0;
    var ZeroCount: i32 = 0;
    var ZeroCountBrute: i32 = 0;
    while (lines.next()) |command| {
        if (command.len == 0) {
            continue;
        }
        const direction = command[0] == 'R';
        const rotationString = command[1..];
        const rotation = try std.fmt.parseInt(i32, rotationString, 10);
        const tuble = safe.turn(rotation, direction);
        ZeroCountBrute += brute.turnBrute(rotation, direction);
        ZeroCount += tuble.@"0";
        if (tuble.@"1") {
            onZeroCount += 1;
        }
    }
    std.debug.print("onZeroCount:{}\n", .{onZeroCount});
    std.debug.print("ZeroCount:{}\n", .{ZeroCount});
    std.debug.print("ZeroCountBrute:{}\n", .{ZeroCountBrute});

    var d: dial = .{ .position = 50 };
    std.debug.print("{}\n", .{d.turn(1000, true)});
}
