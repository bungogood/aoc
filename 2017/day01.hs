import Data.Char (digitToInt)
import Data.List
import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2017/day/1

toDigits :: String -> [Int]
toDigits = map digitToInt . head . lines

offset :: Int -> [Int] -> [(Int, Int)]
offset o xs = zip xs (drop o xs ++ take o xs)

counter :: [(Int, Int)] -> Int
counter = sum . map fst . filter (uncurry (==))

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let digits = toDigits contents
  print (counter $ offset 1 digits)
  print (counter $ offset (div (length digits) 2) digits)
