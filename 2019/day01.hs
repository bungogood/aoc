import System.IO
import Data.List

-- https://adventofcode.com/2019/day/1

toNum :: String -> Int
toNum s = read s :: Int

findMasses :: String -> [Int]
findMasses = map toNum . lines

toFuel :: Int -> Int
toFuel x = x `div` 3 - 2

calFuel :: Int -> Int
calFuel x
  | x <= 0 = 0
  | otherwise = x + calFuel (toFuel x)

main :: IO ()
main = do
  -- handler <- openFile "test/2019/day01.txt" ReadMode
  handler <- openFile "input/2019/day01.txt" ReadMode
  contents <- hGetContents handler
  let masses = findMasses contents
  print (sum $ map toFuel masses)
  print (sum $ map (calFuel . toFuel) masses)
  hClose handler
