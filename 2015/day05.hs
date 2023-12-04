import System.IO
import Data.List (isInfixOf, tails)

-- https://adventofcode.com/2015/day/5

vowels :: String -> Bool
vowels s = length (filter (`elem` "aeiou") s) >= 3

double :: String -> Bool
double s = any (uncurry (==)) $ zip s (tail s)

bad :: String -> Bool
bad s = any (`isInfixOf` s) ["ab", "cd", "pq", "xy"]

niceFirst :: String -> Bool
niceFirst s = vowels s && double s && not (bad s)

pair :: String -> Bool
pair (x:y:xs) = [x,y] `isInfixOf` xs || pair (y:xs)
pair _ = False

repeated :: String -> Bool
repeated (x:y:z:xs) = x == z || repeated (y:z:xs)
repeated _ = False

niceSecond :: String -> Bool
niceSecond s = pair s && repeated s

main :: IO ()
main = do
  -- handler <- openFile "test/2015/day05.txt" ReadMode
  handler <- openFile "input/2015/day05.txt" ReadMode
  contents <- hGetContents handler
  let inputs = lines contents
  print (length $ filter niceFirst inputs)
  print (length $ filter niceSecond inputs)
  hClose handler
