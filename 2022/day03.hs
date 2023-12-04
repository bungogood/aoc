import System.Environment (getArgs)
import System.IO (readFile)
import Control.Monad
import Data.List.Split
import Data.Char
import Data.List

-- https://adventofcode.com/2022/day/3

contains :: Eq a => [a] -> a -> Bool
contains = flip elem

duplicate :: Eq a => [a] -> [a] -> [a]
duplicate x = filter (contains x)

priority :: Char -> Int
priority c | isUpper c = ord c - ord 'A' + 27
           | otherwise = ord c - ord 'a' + 1

toRucksakes :: String -> [String]
toRucksakes = lines

splitBag :: String -> (String, String)
splitBag s = splitAt (div (length s) 2) s

mistakes :: [String] -> Int
mistakes = sum . map (priority . head . uncurry duplicate . splitBag)

findBadge :: [String] -> Char
findBadge (x:xs) = head $ foldr duplicate x xs

common :: (Eq a) => [[a]] -> [a]
common [] = []
common (l:ls) = foldl intersect l ls

badges :: [String] -> Int
badges = sum . map (priority . head. common) . chunksOf 3

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let rucksakes = toRucksakes contents
  print (mistakes rucksakes)
  print (badges rucksakes)
