const std = @import("std");

/// Merge sort implementation in Zig
/// Time complexity: O(n log n)
/// Space complexity: O(n)
///
/// @param allocator Memory allocator for temporary arrays
/// @param arr The array to sort
/// @return void (sorts in place)
pub fn mergeSort(allocator: std.mem.Allocator, arr: []i32) !void {
    if (arr.len <= 1) return;

    // Split array into two halves
    const mid = arr.len / 2;
    const left = arr[0..mid];
    const right = arr[mid..];

    // Recursively sort both halves
    try mergeSort(allocator, left);
    try mergeSort(allocator, right);

    // Merge the sorted halves
    try merge(allocator, arr, left, right);
}

/// Helper function to merge two sorted arrays
///
/// @param allocator Memory allocator for temporary array
/// @param arr The array to merge into
/// @param left First sorted array
/// @param right Second sorted array
/// @return void (merges in place)
fn merge(allocator: std.mem.Allocator, arr: []i32, left: []i32, right: []i32) !void {
    // Create temporary array for merging
    var temp = try allocator.alloc(i32, arr.len);
    defer allocator.free(temp);

    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;

    // Compare elements from both arrays and merge them
    while (i < left.len and j < right.len) {
        if (left[i] <= right[j]) {
            temp[k] = left[i];
            i += 1;
        } else {
            temp[k] = right[j];
            j += 1;
        }
        k += 1;
    }

    // Copy remaining elements from left array
    while (i < left.len) {
        temp[k] = left[i];
        i += 1;
        k += 1;
    }

    // Copy remaining elements from right array
    while (j < right.len) {
        temp[k] = right[j];
        j += 1;
        k += 1;
    }

    // Copy merged array back to original array
    std.mem.copy(i32, arr, temp);
}

pub fn main() !void {
    // Get command line arguments
    var args = try std.process.argsWithAllocator(std.heap.page_allocator);
    defer args.deinit();

    // Skip program name
    _ = args.skip();

    // Get input file path
    const input_file = args.next() orelse {
        std.debug.print("Please provide a file path as an argument\n", .{});
        std.process.exit(1);
    };

    // Create a general purpose allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Read numbers from file
    const file = try std.fs.cwd().openFile(input_file, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var numbers = std.ArrayList(i32).init(allocator);
    defer numbers.deinit();

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const num = try std.fmt.parseInt(i32, line, 10);
        try numbers.append(num);
    }

    // Sort the array
    try mergeSort(allocator, numbers.items);

    // Write sorted numbers back to file
    const out_file = try std.fs.cwd().createFile("sorted_data.txt", .{});
    defer out_file.close();

    var out_stream = out_file.writer();
    for (numbers.items) |num| {
        try out_stream.print("{d}\n", .{num});
    }
}
