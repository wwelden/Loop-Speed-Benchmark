const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const args = try init.minimal.args.toSlice(init.arena.allocator());

    if (args.len < 2) {
        std.debug.print("Please provide a number as command line argument\n", .{});
        std.process.exit(1);
    }

    const input = std.fmt.parseInt(i32, args[1], 10) catch { // Get an input number from the command line
        std.debug.print("Please provide a valid integer\n", .{});
        std.process.exit(1);
    };

    var rand_bytes: u32 = undefined; // Get a random number 0 <= r < 10k
    init.io.random(std.mem.asBytes(&rand_bytes));
    const r: i32 = @intCast(rand_bytes % 10000);
    var a = [_]i32{0} ** 10000; // Array of 10k elements initialized to 0

    for (0..10000) |i| { // 10k outer loop iterations
        var j: i32 = 0;
        while (j < 100000) : (j += 1) { // 100k inner loop iterations, per outer loop iteration
            a[i] = a[i] + @mod(j, input); // Simple sum
        }
        a[i] += r; // Add a random value to each element in array
    }

    var stdout_buffer: [64]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(init.io, &stdout_buffer);
    const stdout = &stdout_writer.interface;
    try stdout.print("{d}\n", .{a[@intCast(r)]}); // Print out a single element from the array
    try stdout.flush();
}
