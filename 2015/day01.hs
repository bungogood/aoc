import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2015/day/1

walk :: Int -> String -> Int
walk f ('(':xs) = walk (f + 1) xs
walk f (')':xs) = walk (f - 1) xs
walk f _ = f

basement :: Int -> Int -> String -> Int
basement f p ('(':xs) = basement (f + 1) (p + 1) xs
basement f p (')':xs) | f == 0 = p + 1
                      | otherwise = basement (f - 1) (p + 1) xs
basement f p _ = p + 1

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  print (walk 0 contents)
  print (basement 0 0 contents)
