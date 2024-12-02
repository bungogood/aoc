import System.Environment (getArgs)
import System.IO (hPutStrLn, readFile, stderr)

-- https://adventofcode.com/2024/day/2

parse :: String -> [[Int]]
parse = map (map read . words) . lines

comp :: (t -> t -> Bool) -> [t] -> Bool
comp cmp (x : y : ys) = cmp y x && comp cmp (y : ys)
comp _ _ = True

allMissing :: [t] -> [[t]]
allMissing (x : xs) = xs : map (x :) (allMissing xs)
allMissing [] = []

isSafe :: [Int] -> Bool
isSafe xs = (comp (<) xs || comp (>) xs) && comp (\x y -> abs (x - y) <= 3) xs

isSafeMissing :: [Int] -> Bool
isSafeMissing = any isSafe . allMissing

main :: IO ()
main = do
  args <- getArgs
  case args of
    [fileName] -> do
      contents <- readFile fileName
      let values = parse contents
      print (length $ filter isSafe values)
      print (length $ filter isSafeMissing values)
    _ -> hPutStrLn stderr "Usage: program <input-file>"
