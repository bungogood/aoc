import Data.List (sort)
import Data.Map qualified as Map
import System.Environment (getArgs)
import System.IO (hPutStrLn, readFile, stderr)

-- https://adventofcode.com/2024/day/1

parse :: String -> [(Int, Int)]
parse = map ((\[a, b] -> (read a, read b)) . words) . lines

sumSortedDiffs :: [Int] -> [Int] -> Int
sumSortedDiffs a b = sum $ zipWith (\a b -> abs (a - b)) (sort a) (sort b)

countOccurances :: [Int] -> Map.Map Int Int
countOccurances = Map.fromListWith (+) . map (,1)

similarityScore :: [Int] -> [Int] -> Int
similarityScore xs = sum . map (\y -> y * lookup y)
  where
    occurrences = countOccurances xs
    lookup y = Map.findWithDefault 0 y occurrences

main :: IO ()
main = do
  args <- getArgs
  case args of
    [fileName] -> do
      contents <- readFile fileName
      let values = unzip $ parse contents
      print (uncurry sumSortedDiffs values)
      print (uncurry similarityScore values)
    _ -> hPutStrLn stderr "Usage: program <input-file>"
