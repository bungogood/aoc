import System.IO
import Data.Set (Set)
import qualified Data.Set as Set

-- https://adventofcode.com/2018/day/1

toNum :: String -> Int
toNum s = read s :: Int

toChange :: String -> Int
toChange ('+':xs) =  toNum xs
toChange ('-':xs) = -toNum xs

repeated :: Int -> Set Int -> [Int] -> [Int] -> Int
repeated value seen [] ls = repeated value seen ls ls
repeated value seen (c:cs) ls | Set.member value seen = value
                              | otherwise = repeated (value + c) (Set.insert value seen) cs ls

main :: IO ()
main = do
  -- handler <- openFile "test/2018/day01.txt" ReadMode
  handler <- openFile "input/2018/day01.txt" ReadMode
  contents <- hGetContents handler
  let changes = map toChange $ lines contents
  print (sum changes)
  print (repeated 0 Set.empty [] changes)
  hClose handler
