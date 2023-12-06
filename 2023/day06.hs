import System.Environment (getArgs)
import System.IO (readFile)
import Data.List.Split (splitOn)

-- https://adventofcode.com/2023/day/6

type Inter = (Int, Int, Int)

toNum :: String -> Int
toNum = read

parse :: [String] -> [(Int, Int)]
parse [time, distance] = zip (finder time) (finder distance)
  where finder = map toNum . tail . words

parse' :: [String] -> (Int, Int)
parse' [time, distance] = (finder time, finder distance)
  where finder = toNum . concat . tail . words

allSpeeds :: (Int, Int) -> [(Int, Int, Int)]
allSpeeds (t, d) = [(t, d, s) | s <- [1..(t-1)]]

calcDist :: (Int, Int, Int) -> (Int, Int)
calcDist (t, d, s) = (d, s * (t - s))

numWin :: (Int, Int) -> Int
numWin = length . filter (uncurry (<)) . map calcDist . allSpeeds

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let races = parse $ lines contents
  let race = parse' $ lines contents
  print $ product $ map numWin races
  print $ numWin race
