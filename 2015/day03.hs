import System.IO
import Data.List.Split
import Data.Set (Set)
import qualified Data.Set as Set

-- https://adventofcode.com/2015/day/3

step :: (Int, Int) -> Char -> (Int, Int)
step (x, y) '>' = (x + 1, y)
step (x, y) '<' = (x - 1, y)
step (x, y) '^' = (x, y + 1)
step (x, y) 'v' = (x, y - 1)

walk :: (Int, Int) -> String -> Set (Int, Int)
walk p = walkRec p (Set.singleton p)

walkRec :: (Int, Int) -> Set (Int, Int) -> String -> Set (Int, Int)
walkRec p v (d:ds) = walkRec (step p d) (Set.insert (step p d) v) ds
walkRec p v [] = v

splitAlt :: String -> (String, String)
splitAlt s = (first, second)
  where
    first = [c | (i, c) <- zip [0..] s, even i]
    second = [c | (i, c) <- zip [0..] s, odd i]

main = do
  handler <- openFile "input/day03.txt" ReadMode
  contents <- hGetContents handler
  let (santa, robo) = splitAlt contents
  print (Set.size $ walk (0, 0) contents)
  print (Set.size $ walk (0, 0) santa `Set.union` walk (0, 0) robo)
  hClose handler
