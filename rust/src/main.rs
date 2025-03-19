use std::fs::File;
use std::io::{self, BufRead, BufReader, Write};
use std::path::Path;

/// Merges two sorted arrays into a single sorted array
fn merge<T: Ord + Clone>(left: &[T], right: &[T]) -> Vec<T> {
    let mut result = Vec::with_capacity(left.len() + right.len());
    let mut left_idx = 0;
    let mut right_idx = 0;

    while left_idx < left.len() && right_idx < right.len() {
        if left[left_idx] <= right[right_idx] {
            result.push(left[left_idx].clone());
            left_idx += 1;
        } else {
            result.push(right[right_idx].clone());
            right_idx += 1;
        }
    }

    result.extend_from_slice(&left[left_idx..]);
    result.extend_from_slice(&right[right_idx..]);
    result
}

/// Sorts an array using the merge sort algorithm
fn merge_sort<T: Ord + Clone>(arr: &[T]) -> Vec<T> {
    if arr.len() <= 1 {
        arr.to_vec()
    } else {
        let mid = arr.len() / 2;
        let left = merge_sort(&arr[..mid]);
        let right = merge_sort(&arr[mid..]);
        merge(&left, &right)
    }
}

/// Reads numbers from a file into a vector
fn read_numbers<P: AsRef<Path>>(path: P) -> io::Result<Vec<i32>> {
    let file = File::open(path)?;
    let reader = BufReader::new(file);
    let mut numbers = Vec::new();

    for line in reader.lines() {
        if let Ok(line) = line {
            if let Ok(num) = line.parse::<i32>() {
                numbers.push(num);
            }
        }
    }

    Ok(numbers)
}

/// Writes numbers to a file
fn write_numbers<P: AsRef<Path>>(path: P, numbers: &[i32]) -> io::Result<()> {
    let mut file = File::create(path)?;
    for &num in numbers {
        writeln!(file, "{}", num)?;
    }
    Ok(())
}

/// Verifies if an array is sorted
fn is_sorted<T: Ord>(arr: &[T]) -> bool {
    arr.windows(2).all(|w| w[0] <= w[1])
}

fn main() {
    // Read input file
    let input_path = "benchmark_input.txt";
    let output_path = "sorted_data.txt";

    match read_numbers(input_path) {
        Ok(numbers) => {
            if numbers.is_empty() {
                eprintln!("Error: Input file is empty");
                return;
            }

            // Sort the numbers
            let sorted = merge_sort(&numbers);

            // Verify sorting
            if !is_sorted(&sorted) {
                eprintln!("Error: Sorting verification failed");
                return;
            }

            // Write output
            if let Err(e) = write_numbers(output_path, &sorted) {
                eprintln!("Error writing output file: {}", e);
                return;
            }
        }
        Err(e) => {
            eprintln!("Error reading input file: {}", e);
            return;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_empty_array() {
        let arr: Vec<i32> = vec![];
        let sorted = merge_sort(&arr);
        assert!(sorted.is_empty());
        assert!(is_sorted(&sorted));
    }

    #[test]
    fn test_single_element() {
        let arr = vec![42];
        let sorted = merge_sort(&arr);
        assert_eq!(sorted, vec![42]);
        assert!(is_sorted(&sorted));
    }

    #[test]
    fn test_two_elements() {
        let arr = vec![2, 1];
        let sorted = merge_sort(&arr);
        assert_eq!(sorted, vec![1, 2]);
        assert!(is_sorted(&sorted));
    }

    #[test]
    fn test_multiple_elements() {
        let arr = vec![5, 2, 8, 1, 9];
        let sorted = merge_sort(&arr);
        assert_eq!(sorted, vec![1, 2, 5, 8, 9]);
        assert!(is_sorted(&sorted));
    }

    #[test]
    fn test_duplicate_elements() {
        let arr = vec![3, 1, 3, 2, 3];
        let sorted = merge_sort(&arr);
        assert_eq!(sorted, vec![1, 2, 3, 3, 3]);
        assert!(is_sorted(&sorted));
    }

    #[test]
    fn test_negative_numbers() {
        let arr = vec![-5, 2, -8, 1, -9];
        let sorted = merge_sort(&arr);
        assert_eq!(sorted, vec![-9, -8, -5, 1, 2]);
        assert!(is_sorted(&sorted));
    }

    #[test]
    fn test_large_array() {
        let arr: Vec<i32> = (0..1000).rev().collect();
        let sorted = merge_sort(&arr);
        assert!(is_sorted(&sorted));
        assert_eq!(sorted.len(), 1000);
    }
}
