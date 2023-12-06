import System.Environment (getArgs)
import System.IO (readFile)
import Data.List.Split (splitOn)

-- https://adventofcode.com/2023/day/6

toNum :: String -> Int
toNum = read

parse :: [String] -> [(Int, Int)]
parse [time, distance] = zip (finder time) (finder distance)
  where finder = map toNum . tail . words

parse' :: [String] -> (Int, Int)
parse' [time, distance] = (finder time, finder distance)
  where finder = toNum . concat . tail . words

numWin :: (Int, Int) -> Int
numWin (t, d) = max 0 (ceiling upper - floor lower - 1)
  where
    (a, b, c) = (1.0, fromIntegral (-t), fromIntegral d)
    discriminant = sqrt (b^2 - 4*a*c)
    lower = (-b - discriminant) / (2*a)
    upper = (-b + discriminant) / (2*a)

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let races = parse $ lines contents
  let race = parse' $ lines contents
  print $ product $ map numWin races
  print $ numWin race
