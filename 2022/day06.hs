import System.Environment (getArgs)
import System.IO (readFile)
import Control.Monad
import Data.List

-- https://adventofcode.com/2022/day/6

buffer :: Int -> String -> Int
buffer n s
  | nub (take n s) == take n s = n
  | otherwise = 1 + buffer n (tail s) 

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  print (buffer 4 contents)
  print (buffer 14 contents)
