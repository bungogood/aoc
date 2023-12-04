import System.Environment (getArgs)
import System.IO (readFile)
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
  args <- getArgs
  contents <- readFile (head args)
  let elfData = elfCals contents
  print (bestElf elfData)
  print (topElves 3 elfData)
