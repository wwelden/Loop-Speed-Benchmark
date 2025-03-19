{-|
Module      : MergeSort
Description : Implementation of merge sort algorithm in Haskell
Copyright   : (c) 2024
License     : MIT
Maintainer  : Assistant
Stability   : experimental
Portability : POSIX

This module provides a pure functional implementation of the merge sort algorithm.
The implementation is generic and can sort any list of elements that implement
the Ord typeclass.

Time complexity: O(n log n)
Space complexity: O(n)
-}

module MergeSort
    ( mergeSort
    , merge
    , isSorted
    ) where

import System.IO
import Control.Monad

-- | Sorts a list using merge sort algorithm.
-- The input list must contain elements that implement the Ord typeclass.
mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right)
    where
        (left, right) = splitAt (length xs `div` 2) xs

-- | Merges two sorted lists into a single sorted list.
-- Both input lists must be sorted and contain elements that implement the Ord typeclass.
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

-- | Checks if a list is sorted in ascending order.
-- The input list must contain elements that implement the Ord typeclass.
isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x:y:xs) = x <= y && isSorted (y:xs)

-- | Main function for command-line interface
main :: IO ()
main = do
    args <- getArgs
    case args of
        [] -> putStrLn "Please provide an input file path"
        (file:_) -> do
            content <- readFile file
            let numbers = map read $ lines content :: [Int]
            let sorted = mergeSort numbers
            writeFile "sorted_data.txt" $ unlines $ map show sorted

-- | Test suite
tests :: IO Bool
tests = do
    let testCases = [
            ("Empty list", mergeSort [] == []),
            ("Single element", mergeSort [1] == [1]),
            ("Two elements", mergeSort [2,1] == [1,2]),
            ("Multiple elements", mergeSort [5,3,8,4,2] == [2,3,4,5,8]),
            ("Duplicate elements", mergeSort [3,1,4,1,5,9,2,6,5,3,5] == [1,1,2,3,3,4,5,5,5,6,9]),
            ("Negative numbers", mergeSort [-3,1,-4,1,-5,9,-2,6,-5,3,-5] == [-5,-5,-5,-4,-3,-2,1,1,3,6,9]),
            ("Large list", isSorted $ mergeSort [1000,999..1]),
            ("Strings", mergeSort ["banana","apple","cherry"] == ["apple","banana","cherry"])
        ]

    let results = map (\(name, result) -> (name, result)) testCases
    let failures = filter (not . snd) results

    putStrLn "Running tests..."
    forM_ results $ \(name, result) -> do
        putStrLn $ name ++ ": " ++ if result then "PASSED" else "FAILED"

    return $ null failures

-- | Run tests if DEBUG is set
#ifdef DEBUG
main = tests >>= \passed -> if passed then putStrLn "All tests passed!" else putStrLn "Some tests failed!"
#endif
