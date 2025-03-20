#!/bin/bash

# Import binary search function
source ../src/binary_search.sh

# Test helper function
assert_equal() {
    local expected=$1
    local actual=$2
    local message=$3

    if [ "$expected" = "$actual" ]; then
        echo "✓ $message"
        return 0
    else
        echo "✗ $message: expected $expected, got $actual"
        return 1
    fi
}

# Test cases
test_binary_search() {
    local passed=0
    local total=0

    # Test 1: Target in middle
    arr1=(1 2 3 4 5)
    result=$(binary_search 3 "${arr1[@]}")
    if assert_equal 2 "$result" "Should find target in middle"; then
        ((passed++))
    fi
    ((total++))

    # Test 2: Target at start
    result=$(binary_search 1 "${arr1[@]}")
    if assert_equal 0 "$result" "Should find target at start"; then
        ((passed++))
    fi
    ((total++))

    # Test 3: Target at end
    result=$(binary_search 5 "${arr1[@]}")
    if assert_equal 4 "$result" "Should find target at end"; then
        ((passed++))
    fi
    ((total++))

    # Test 4: Target not present
    result=$(binary_search 6 "${arr1[@]}")
    if assert_equal -1 "$result" "Should return -1 when target not found"; then
        ((passed++))
    fi
    ((total++))

    # Test 5: Empty array
    arr2=()
    result=$(binary_search 1 "${arr2[@]}")
    if assert_equal -1 "$result" "Should handle empty array"; then
        ((passed++))
    fi
    ((total++))

    # Test 6: Single element
    arr3=(1)
    result=$(binary_search 1 "${arr3[@]}")
    if assert_equal 0 "$result" "Should handle single element"; then
        ((passed++))
    fi
    ((total++))

    # Test 7: Negative numbers
    arr4=(-5 -3 -1 0 2)
    result=$(binary_search -3 "${arr4[@]}")
    if assert_equal 1 "$result" "Should handle negative numbers"; then
        ((passed++))
    fi
    ((total++))

    # Test 8: Duplicate elements
    arr5=(1 2 2 2 3)
    result=$(binary_search 2 "${arr5[@]}")
    if assert_equal 1 "$result" "Should find first occurrence"; then
        ((passed++))
    fi
    ((total++))

    # Print summary
    echo
    echo "Test Summary: $passed/$total tests passed"
    return $((total - passed))
}

# Run tests
test_binary_search
exit $?
