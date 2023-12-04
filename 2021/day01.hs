import System.Environment (getArgs)
import System.IO (readFile)
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

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let depths = findDepths contents
  print (increases depths)
  print (increases . map sum $ slidingWindow 3 depths)
