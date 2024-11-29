import Data.List (find)
import Data.Maybe (fromJust)
import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2015/day/1

updateFloor :: Int -> Char -> Int
updateFloor f '(' = f + 1
updateFloor f ')' = f - 1

walk :: String -> Int
walk = foldl updateFloor 0

basement :: String -> Maybe Int
basement = fmap (subtract 1 . fst) . find ((== -1) . snd) . zip [1 ..] . scanl updateFloor 0

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  print (walk contents)
  print (fromJust $ basement contents)
