import System.IO
import Data.List
import Data.Char (digitToInt)

-- https://adventofcode.com/2017/day/1

toDigits :: String -> [Int]
toDigits = map digitToInt . head . lines

offset :: Int -> [Int] -> [(Int, Int)]
offset o xs = zip xs (drop o xs ++ take o xs)

counter :: [(Int, Int)] -> Int
counter = sum . map fst . filter (uncurry (==))

main :: IO ()
main = do
  -- handler <- openFile "test/2017/day01.txt" ReadMode
  handler <- openFile "input/2017/day01.txt" ReadMode
  contents <- hGetContents handler
  let digits = toDigits contents
  print (counter $ offset 1 digits)
  print (counter $ offset (div (length digits) 2) digits)
  hClose handler
