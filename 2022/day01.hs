import System.IO  
import Control.Monad
import Data.List.Split
import Data.List

-- https://adventofcode.com/2022/day/1

toNum :: String -> Int
toNum s = read s :: Int

elfCals :: String -> [[Int]]
elfCals = map (map toNum) . splitOn [""] . lines

bestElf :: [[Int]] -> Int
bestElf = maximum . map sum

topElves :: Int -> [[Int]] -> Int
topElves n = sum . take n . reverse . sort . map sum

main :: IO ()
main = do
  -- handler <- openFile "test/2022/day01.txt" ReadMode
  handler <- openFile "input/2022/day01.txt" ReadMode
  contents <- hGetContents handler
  let elfData = elfCals contents
  print (bestElf elfData)
  print (topElves 3 elfData)
  hClose handler
