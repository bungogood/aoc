import System.IO  
import Control.Monad
import Data.List

buffer :: Int -> String -> Int
buffer n s
  | nub (take n s) == take n s = n
  | otherwise = 1 + buffer n (tail s) 

main = do
  handler <- openFile "input/day06.txt" ReadMode
  contents <- hGetContents handler
  print (buffer 4 contents)
  print (buffer 14 contents)
  hClose handler
