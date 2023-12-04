import System.Environment (getArgs)
import System.IO (readFile)
import Data.List.Split

-- https://adventofcode.com/2015/day/2

toNum :: String -> Int
toNum s = read s :: Int

toBoxes :: String -> [(Int, Int, Int)]
toBoxes = map ((\[l, w, h] -> (toNum l, toNum w, toNum h)) . splitOn "x") . lines

wrapping :: (Int, Int, Int) -> Int
wrapping (l, w, h) = 2 * l * w + 2 * w * h + 2 * h * l + minimum [l * w, w * h, h * l]

ribbon :: (Int, Int, Int) -> Int
ribbon (l, w, h) = minimum [2 * l + 2 * w, 2 * w + 2 * h, 2 * h + 2 * l] + l * w * h

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let boxes = toBoxes contents
  print (sum . map wrapping $ boxes)
  print (sum . map ribbon $ boxes)
