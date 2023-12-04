import System.IO

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
  -- handler <- openFile "test/2015/day01.txt" ReadMode
  handler <- openFile "input/2015/day01.txt" ReadMode
  contents <- hGetContents handler
  print (walk 0 contents)
  print (basement 0 0 contents)
  hClose handler
