import System.Environment (getArgs)
import System.IO (readFile)
import Control.Monad
import Data.List.Split
import Data.List
import Data.Char

-- https://adventofcode.com/2022/day/4

toNum :: String -> Int
toNum s = read s :: Int

toList :: (Int, Int) -> [Int]
toList (x, y) = [x..y]

toTuple :: [a] -> (a, a)
toTuple [x, y] = (x, y)

toRange :: String -> (Int, Int)
toRange = toTuple . map toNum . splitOn "-"

readRanges :: String -> [((Int, Int), (Int, Int))]
readRanges = map (toTuple . map toRange . splitOn ",") . lines

inside :: ((Int, Int), (Int, Int)) -> Bool
inside ((a, b), (c, d)) = (a <= c && d <= b) || (c <= a && b <= d)

overlap :: ((Int, Int), (Int, Int)) -> Bool
overlap ((a, b), (c, d)) = (c >= a || d >= a) && (b >= c || b >= d)

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let ranges = readRanges contents
  print (length $ filter inside  ranges)
  print (length $ filter overlap ranges)
