const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        try std.io.getStdErr().writer().print("Please provide a number as command line argument\n", .{});
        std.process.exit(1);
    }

    const input = std.fmt.parseInt(i32, args[1], 10) catch {  // Get an input number from the command line
        try std.io.getStdErr().writer().print("Please provide a valid integer\n", .{});
        std.process.exit(1);
    };

    var rng = std.crypto.random;
    const r = rng.intRangeAtMost(i32, 0, 9999);    // Get a random number 0 <= r < 10k
    var a = [_]i32{0} ** 10000;                    // Array of 10k elements initialized to 0

    var i: i32 = 0;
    while (i < 10000) : (i += 1) {                 // 10k outer loop iterations
        var j: i32 = 0;
        while (j < 100000) : (j += 1) {            // 100k inner loop iterations
            a[@intCast(i)] = a[@intCast(i)] + @mod(j, input);  // Simple sum
        }
        a[@intCast(i)] += r;                       // Add a random value to each element in array
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{d}\n", .{a[@intCast(r)]});  // Print out a single element from the array
}
