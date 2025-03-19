module BinarySearchTest (tests) where

import Test.HUnit
import BinarySearch

-- Test cases
tests :: Test
tests = TestList [
    "test_binary_search" ~: TestList [
        "target in middle" ~: assertEqual "Should find target in middle" (Just 2) (binarySearch [1,2,3,4,5] 3),
        "target at start" ~: assertEqual "Should find target at start" (Just 0) (binarySearch [1,2,3,4,5] 1),
        "target at end" ~: assertEqual "Should find target at end" (Just 4) (binarySearch [1,2,3,4,5] 5),
        "target not present" ~: assertEqual "Should return Nothing when target not found" Nothing (binarySearch [1,2,3,4,5] 6),
        "empty list" ~: assertEqual "Should handle empty list" Nothing (binarySearch [] 1),
        "single element" ~: assertEqual "Should handle single element" (Just 0) (binarySearch [1] 1),
        "negative numbers" ~: assertEqual "Should handle negative numbers" (Just 2) (binarySearch [-3,-2,-1,0,1] -1),
        "duplicate elements" ~: assertEqual "Should find first occurrence" (Just 1) (binarySearch [1,2,2,2,3] 2)
    ]
]

main :: IO Counts
main = runTestTT tests
