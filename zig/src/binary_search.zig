const std = @import("std");

/// Performs binary search to find the index of target in a sorted array.
/// Returns null if the target is not found.
///
/// Parameters:
///   - arr: A sorted slice of integers
///   - target: The value to search for
///
/// Returns:
///   - The index of target if found, null otherwise
///
/// Complexity:
///   - Time: O(log n)
///   - Space: O(1)
pub fn binarySearch(comptime T: type, arr: []const T, target: T) ?usize {
    if (arr.len == 0) {
        return null;
    }

    var left: usize = 0;
    var right: usize = arr.len - 1;

    while (left <= right) {
        const mid = (left + right) / 2;

        switch (std.math.order(arr[mid], target)) {
            .eq => return mid,
            .lt => left = mid + 1,
            .gt => {
                if (mid == 0) {
                    break;
                }
                right = mid - 1;
            },
        }
    }

    return null;
}

pub fn main() void {
    // Test cases
    const test_cases = [_]struct { arr: []const i32, target: i32 }{
        .{ .arr = &[_]i32{ 1, 2, 3, 4, 5 }, .target = 3 }, // Target in middle
        .{ .arr = &[_]i32{ 1, 2, 3, 4, 5 }, .target = 1 }, // Target at start
        .{ .arr = &[_]i32{ 1, 2, 3, 4, 5 }, .target = 5 }, // Target at end
        .{ .arr = &[_]i32{ 1, 2, 3, 4, 5 }, .target = 6 }, // Target not present
        .{ .arr = &[_]i32{}, .target = 1 }, // Empty array
        .{ .arr = &[_]i32{1}, .target = 1 }, // Single element
    };

    for (test_cases) |case| {
        const result = binarySearch(i32, case.arr, case.target);
        std.debug.print("Array: {any}, Target: {}, Result: {?}\n", .{ case.arr, case.target, result });
    }
}
