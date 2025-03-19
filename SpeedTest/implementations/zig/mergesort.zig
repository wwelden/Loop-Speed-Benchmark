const std = @import("std");
const time = std.time;

fn merge(arr: []i32, left: []i32, right: []i32) void {
    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;

    while (i < left.len and j < right.len) {
        if (left[i] <= right[j]) {
            arr[k] = left[i];
            i += 1;
        } else {
            arr[k] = right[j];
            j += 1;
        }
        k += 1;
    }

    while (i < left.len) {
        arr[k] = left[i];
        i += 1;
        k += 1;
    }

    while (j < right.len) {
        arr[k] = right[j];
        j += 1;
        k += 1;
    }
}

fn mergeSort(arr: []i32) void {
    if (arr.len <= 1) {
        return;
    }

    const mid = arr.len / 2;
    const left = arr[0..mid];
    const right = arr[mid..];

    mergeSort(left);
    mergeSort(right);

    var temp = std.heap.page_allocator.alloc(i32, arr.len) catch unreachable;
    defer std.heap.page_allocator.free(temp);

    std.mem.copy(i32, temp[0..], left);
    std.mem.copy(i32, temp[mid..], right);

    merge(arr, temp[0..mid], temp[mid..]);
}

fn generateRandomArray(allocator: std.mem.Allocator, size: usize) ![]i32 {
    const arr = try allocator.alloc(i32, size);
    var rng = std.crypto.random;

    for (arr) |*item| {
        item.* = @intCast(rng.intRangeAtMost(i32, 0, 9999));
    }

    return arr;
}

pub fn main() void {
    const ARRAY_SIZE = 1000;
    const ITERATIONS = 100;

    var i: usize = 0;
    while (i < ITERATIONS) : (i += 1) {
        const arr = generateRandomArray(std.heap.page_allocator, ARRAY_SIZE) catch unreachable;
        defer std.heap.page_allocator.free(arr);

        mergeSort(arr);
    }
}
