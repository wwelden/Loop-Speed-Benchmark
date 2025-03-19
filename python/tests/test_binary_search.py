import pytest
from src.binary_search import binary_search

def test_binary_search():
    # Test with target in middle
    assert binary_search([1, 2, 3, 4, 5], 3) == 2

    # Test with target at start
    assert binary_search([1, 2, 3, 4, 5], 1) == 0

    # Test with target at end
    assert binary_search([1, 2, 3, 4, 5], 5) == 4

    # Test with target not present
    assert binary_search([1, 2, 3, 4, 5], 6) is None

    # Test with empty array
    assert binary_search([], 1) is None

    # Test with single element
    assert binary_search([1], 1) == 0

    # Test with negative numbers
    assert binary_search([-5, -3, -1, 0, 2], -3) == 1

    # Test with duplicate elements (should return first occurrence)
    assert binary_search([1, 2, 2, 2, 3], 2) == 1
