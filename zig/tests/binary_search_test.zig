const std = @import("std");
const testing = std.testing;
const binarySearch = @import("../src/binary_search.zig").binarySearch;

test "binary search" {
    // Test with target in middle
    try testing.expectEqual(@as(?usize, 2), binarySearch(i32, &[_]i32{ 1, 2, 3, 4, 5 }, 3));

    // Test with target at start
    try testing.expectEqual(@as(?usize, 0), binarySearch(i32, &[_]i32{ 1, 2, 3, 4, 5 }, 1));

    // Test with target at end
    try testing.expectEqual(@as(?usize, 4), binarySearch(i32, &[_]i32{ 1, 2, 3, 4, 5 }, 5));

    // Test with target not present
    try testing.expectEqual(@as(?usize, null), binarySearch(i32, &[_]i32{ 1, 2, 3, 4, 5 }, 6));

    // Test with empty array
    try testing.expectEqual(@as(?usize, null), binarySearch(i32, &[_]i32{}, 1));

    // Test with single element
    try testing.expectEqual(@as(?usize, 0), binarySearch(i32, &[_]i32{1}, 1));

    // Test with negative numbers
    try testing.expectEqual(@as(?usize, 1), binarySearch(i32, &[_]i32{ -5, -3, -1, 0, 2 }, -3));

    // Test with duplicate elements (should return first occurrence)
    try testing.expectEqual(@as(?usize, 1), binarySearch(i32, &[_]i32{ 1, 2, 2, 2, 3 }, 2));
}
