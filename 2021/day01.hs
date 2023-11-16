import System.IO  
import Control.Monad
import Data.List.Split
import Data.List

-- https://adventofcode.com/2021/day/1

toNum :: String -> Int
toNum s = read s :: Int

findDepths :: String -> [Int]
findDepths = map toNum . lines

increases :: [Int] -> Int
increases xs = length . filter (uncurry (<)) $ zip xs (tail xs)

slidingWindow :: Int -> [a] -> [[a]]
slidingWindow n = filter ((== n) . length) . map (take n) . tails

mean :: [Int] -> Int
mean xs = sum xs `div` length xs

main = do
  handler <- openFile "input/day01.txt" ReadMode
  contents <- hGetContents handler
  let depths = findDepths contents
  print (increases depths)
  print (increases . map sum $ slidingWindow 3 depths)
  hClose handler
