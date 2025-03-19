{-|
Module      : BinarySearch
Description : Binary search implementation in Haskell
Copyright   : (c) 2024
License     : MIT
Maintainer  : example@example.com

This module provides a binary search implementation for sorted lists.
-}

module BinarySearch
    ( binarySearch
    ) where

-- | Performs binary search to find the index of target in a sorted list.
-- Returns Nothing if the target is not found.
--
-- >>> binarySearch [1,2,3,4,5] 3
-- Just 2
--
-- >>> binarySearch [1,2,3,4,5] 6
-- Nothing
--
-- >>> binarySearch [] 1
-- Nothing
--
-- >>> binarySearch [1] 1
-- Just 0
--
-- Complexity:
--   * Time: O(log n)
--   * Space: O(1)
binarySearch :: (Ord a) => [a] -> a -> Maybe Int
binarySearch [] _ = Nothing
binarySearch xs target = go xs target 0 (length xs - 1)
  where
    go :: (Ord a) => [a] -> a -> Int -> Int -> Maybe Int
    go xs target left right
      | left > right = Nothing
      | otherwise = let mid = (left + right) `div` 2
                        midVal = xs !! mid
                    in case compare midVal target of
                         EQ -> Just mid
                         LT -> go xs target (mid + 1) right
                         GT -> if mid == 0 then Nothing
                               else go xs target left (mid - 1)

-- Example usage
main :: IO ()
main = do
    -- Test cases
    let testCases = [
            ([1,2,3,4,5], 3),    -- Target in middle
            ([1,2,3,4,5], 1),    -- Target at start
            ([1,2,3,4,5], 5),    -- Target at end
            ([1,2,3,4,5], 6),    -- Target not present
            ([], 1),             -- Empty list
            ([1], 1)             -- Single element
          ]

    -- Run tests
    mapM_ (\(xs, target) -> do
        putStrLn $ "Array: " ++ show xs ++ ", Target: " ++ show target ++
                   ", Result: " ++ show (binarySearch xs target))
        ) testCases
