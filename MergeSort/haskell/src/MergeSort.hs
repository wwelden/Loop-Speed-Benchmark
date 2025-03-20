module Main where

import System.Environment (getArgs)
import System.IO (readFile, writeFile)

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

main :: IO ()
main = do
    args <- getArgs
    case args of
        [inputFile] -> do
            content <- readFile inputFile
            let numbers = map read $ lines content :: [Int]
            let sorted = mergeSort numbers
            writeFile "sorted_data.txt" $ unlines $ map show sorted
        _ -> putStrLn "Usage: MergeSort <input_file>"
