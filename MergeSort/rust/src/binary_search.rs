/// Performs binary search to find the index of target in a sorted array.
///
/// # Arguments
///
/// * `arr` - A sorted slice of integers
/// * `target` - The value to search for
///
/// # Returns
///
/// * `Option<usize>` - The index of target if found, None otherwise
///
/// # Examples
///
/// ```
/// let arr = vec![1, 2, 3, 4, 5];
/// assert_eq!(binary_search(&arr, 3), Some(2));
/// assert_eq!(binary_search(&arr, 6), None);
/// ```
///
/// # Time Complexity
/// O(log n)
///
/// # Space Complexity
/// O(1)
pub fn binary_search(arr: &[i32], target: i32) -> Option<usize> {
    if arr.is_empty() {
        return None;
    }

    let mut left = 0;
    let mut right = arr.len() - 1;

    while left <= right {
        let mid = (left + right) / 2;

        match arr[mid].cmp(&target) {
            std::cmp::Ordering::Equal => return Some(mid),
            std::cmp::Ordering::Less => left = mid + 1,
            std::cmp::Ordering::Greater => {
                if mid == 0 {
                    break;
                }
                right = mid - 1;
            }
        }
    }

    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_binary_search() {
        // Test with target in middle
        assert_eq!(binary_search(&[1, 2, 3, 4, 5], 3), Some(2));

        // Test with target at start
        assert_eq!(binary_search(&[1, 2, 3, 4, 5], 1), Some(0));

        // Test with target at end
        assert_eq!(binary_search(&[1, 2, 3, 4, 5], 5), Some(4));

        // Test with target not present
        assert_eq!(binary_search(&[1, 2, 3, 4, 5], 6), None);

        // Test with empty array
        assert_eq!(binary_search(&[], 1), None);

        // Test with single element
        assert_eq!(binary_search(&[1], 1), Some(0));

        // Test with negative numbers
        assert_eq!(binary_search(&[-5, -3, -1, 0, 2], -3), Some(1));

        // Test with duplicate elements (should return first occurrence)
        assert_eq!(binary_search(&[1, 2, 2, 2, 3], 2), Some(1));
    }
}

fn main() {
    // Example usage
    let test_cases = vec![
        (vec![1, 2, 3, 4, 5], 3),      // Target in middle
        (vec![1, 2, 3, 4, 5], 1),      // Target at start
        (vec![1, 2, 3, 4, 5], 5),      // Target at end
        (vec![1, 2, 3, 4, 5], 6),      // Target not present
        (vec![], 1),                    // Empty array
        (vec![1], 1),                   // Single element
    ];

    for (arr, target) in test_cases {
        let result = binary_search(&arr, target);
        println!("Array: {:?}, Target: {}, Result: {:?}", arr, target, result);
    }
}
