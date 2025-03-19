#!/usr/bin/env runhaskell

import System.Random
import Control.Monad

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right)
    where
        (left, right) = splitAt (length xs `div` 2) xs

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

generateRandomArray :: Int -> IO [Int]
generateRandomArray size = replicateM size (randomRIO (1, 1000))

main :: IO ()
main = do
    let size = 1000
    -- Run 100 times with different random arrays
    replicateM_ 100 $ do
        arr <- generateRandomArray size
        let _ = mergeSort arr
        return ()
