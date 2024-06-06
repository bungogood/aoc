import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2023/day/9

parse :: String -> [[Int]]
parse = map (map read . words) . lines

diffs :: [Int] -> [Int]
diffs (x:y:xs) = (y - x) : diffs (y:xs)
diffs _ = []

expand :: [Int] -> (Int, Int)
expand xs
    | all (==0) xs = (0, 0)
    | otherwise = (head xs - pre, last xs + post)
    where (pre, post) = expand (diffs xs)

aggregate :: [[Int]] -> (Int, Int)
aggregate = foldl sumPair (0, 0) . map expand
  where sumPair (a, b) (c, d) = (a + c, b + d)

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let seqs = parse contents
  let (pre, post) = aggregate seqs
  print post
  print pre
