import System.IO  
import Control.Monad
import Data.List.Split
import Data.Char
import Data.List

contains :: Eq a => [a] -> a -> Bool
contains = flip (any . (==))

duplicate :: Eq a => [a] -> [a] -> [a]
duplicate x = filter (contains x)

priority :: Char -> Int
priority c | isUpper c = ord c - ord 'A' + 27
           | otherwise = ord c - ord 'a' + 1

toRucksakes :: String -> [String]
toRucksakes = splitOn "\n"

splitBag :: String -> (String, String)
splitBag s = (take (div (length s) 2) s, drop (div (length s) 2) s)

mistakes :: [String] -> Int
mistakes = sum . map (priority . head . uncurry duplicate . splitBag)

findBadge :: [String] -> Char
findBadge (x:xs) = head $ foldr duplicate x xs

badges :: [String] -> Int
badges = sum . map (priority . common) . splitEvery 3

main = do
  handler <- openFile "input/day03.txt" ReadMode
  contents <- hGetContents handler
  let rucksakes = toRucksakes contents
  print (mistakes rucksakes)
  print (badges rucksakes)
  hClose handler
