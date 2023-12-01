import System.IO
import Data.Set (Set, insert, member, empty)

-- https://adventofcode.com/2018/day/1

toNum :: String -> Int
toNum s = read s :: Int

toChange :: String -> Int
toChange ('+':xs) =  toNum xs
toChange ('-':xs) = -toNum xs

repeated :: Int -> Set Int -> [Int] -> [Int] -> Int
repeated value seen [] ls = repeated value seen ls ls
repeated value seen (c:cs) ls | member value seen = value
                              | otherwise = repeated (value + c) (insert value seen) cs ls

main :: IO ()
main = do
  handler <- openFile "input/day01.txt" ReadMode
  contents <- hGetContents handler
  let changes = map toChange $ lines contents
  print (sum changes)
  print (repeated 0 empty [] changes)
  hClose handler
