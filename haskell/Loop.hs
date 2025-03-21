import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)
import System.Random (randomRIO)
import Data.Array.IO
import Control.Monad (forM_)
import Text.Read (readMaybe)

main :: IO ()
main = do
    args <- getArgs
    case args of
        [] -> do
            hPutStrLn stderr "Please provide a number as command line argument"
            exitFailure
        (arg:_) -> case readMaybe arg of
            Nothing -> do
                hPutStrLn stderr "Please provide a valid integer"
                exitFailure
            Just input -> do                                    -- Get an input number from the command line
                r <- randomRIO (0, 9999)                       -- Get a random number 0 <= r < 10k
                arr <- newArray (0, 9999) 0 :: IO (IOArray Int Int)  -- Array of 10k elements initialized to 0

                forM_ [0..9999] $ \i -> do                     -- 10k outer loop iterations
                    forM_ [0..99999] $ \j -> do                -- 100k inner loop iterations
                        current <- readArray arr i
                        writeArray arr i (current + j `mod` input)  -- Simple sum
                    current <- readArray arr i
                    writeArray arr i (current + r)              -- Add a random value to each element

                result <- readArray arr r                       -- Print out a single element from the array
                print result
