use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};
use std::path::Path;

/// Implementation of merge sort algorithm in Rust
/// Time complexity: O(n log n)
/// Space complexity: O(n)
pub fn merge_sort<T: Ord + Clone>(arr: &[T]) -> Vec<T> {
    if arr.len() <= 1 {
        return arr.to_vec();
    }

    // Split array into two halves
    let mid = arr.len() / 2;
    let left = &arr[..mid];
    let right = &arr[mid..];

    // Recursively sort both halves
    merge(&merge_sort(left), &merge_sort(right))
}

/// Helper function to merge two sorted slices into a single sorted vector
fn merge<T: Ord + Clone>(left: &[T], right: &[T]) -> Vec<T> {
    let mut result = Vec::with_capacity(left.len() + right.len());
    let mut i = 0;
    let mut j = 0;

    // Compare elements from both slices and merge them
    while i < left.len() && j < right.len() {
        if left[i] <= right[j] {
            result.push(left[i].clone());
            i += 1;
        } else {
            result.push(right[j].clone());
            j += 1;
        }
    }

    // Copy remaining elements from left slice
    result.extend_from_slice(&left[i..]);

    // Copy remaining elements from right slice
    result.extend_from_slice(&right[j..]);

    result
}

fn main() -> io::Result<()> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        eprintln!("Please provide a file path as an argument");
        std::process::exit(1);
    }

    // Read numbers from file
    let file = File::open(&args[1])?;
    let reader = BufReader::new(file);
    let numbers: Vec<i32> = reader
        .lines()
        .filter_map(|line| line.ok())
        .filter_map(|line| line.trim().parse().ok())
        .collect();

    // Sort the array
    let sorted_numbers = merge_sort(&numbers);

    // Write sorted numbers back to file
    let mut output_file = File::create("sorted_data.txt")?;
    for num in sorted_numbers {
        writeln!(output_file, "{}", num)?;
    }

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    fn is_sorted<T: Ord>(arr: &[T]) -> bool {
        for i in 1..arr.len() {
            if arr[i - 1] > arr[i] {
                return false;
            }
        }
        true
    }

    #[test]
    fn test_empty_array() {
        let arr: Vec<i32> = vec![];
        let result = merge_sort(&arr);
        assert!(result.is_empty());
        assert!(is_sorted(&result));
    }

    #[test]
    fn test_single_element() {
        let arr = vec![1];
        let result = merge_sort(&arr);
        assert_eq!(result, vec![1]);
        assert!(is_sorted(&result));
    }

    #[test]
    fn test_two_elements() {
        let arr = vec![2, 1];
        let result = merge_sort(&arr);
        assert_eq!(result, vec![1, 2]);
        assert!(is_sorted(&result));
    }

    #[test]
    fn test_multiple_elements() {
        let arr = vec![5, 3, 8, 4, 2];
        let result = merge_sort(&arr);
        assert_eq!(result, vec![2, 3, 4, 5, 8]);
        assert!(is_sorted(&result));
    }

    #[test]
    fn test_duplicate_elements() {
        let arr = vec![3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
        let result = merge_sort(&arr);
        assert!(is_sorted(&result));
    }

    #[test]
    fn test_negative_numbers() {
        let arr = vec![-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5];
        let result = merge_sort(&arr);
        assert!(is_sorted(&result));
    }

    #[test]
    fn test_large_array() {
        let arr: Vec<i32> = (0..1000).map(|i| i % 1000).collect();
        let result = merge_sort(&arr);
        assert!(is_sorted(&result));
    }

    #[test]
    fn test_strings() {
        let arr = vec!["banana", "apple", "cherry", "date", "elderberry"];
        let result = merge_sort(&arr);
        assert!(is_sorted(&result));
    }
}
