import Data.List (sort)
import Data.Map qualified as Map
import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2024/day/1

toNum :: String -> Int
toNum s = read s

parse :: String -> [(Int, Int)]
parse = map (parse' . words) . lines
  where
    parse' [a, b] = (toNum a, toNum b)

reform :: [(Int, Int)] -> ([Int], [Int])
reform = foldr (\(a, b) (accA, accB) -> (a : accA, b : accB)) ([], [])

sortedDiffs :: ([Int], [Int]) -> [Int]
sortedDiffs (a, b) = map abs $ zipWith (-) (sort a) (sort b)

countOccurances :: [Int] -> Map.Map Int Int
countOccurances = Map.fromListWithKey (\_ a b -> a + b) . map (\x -> (x, 1))

similarity :: Map.Map Int Int -> [Int] -> [Int]
similarity lookup = map (\x -> x * Map.findWithDefault 0 x lookup)

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let values = reform $ parse contents
  print (sum $ sortedDiffs values)
  print (sum $ similarity (countOccurances $ fst values) $ snd values)
