import System.IO
import Control.Monad
import Data.List.Split
import Data.List

-- https://adventofcode.com/2020/day/8

type Instr = Int

execute :: String -> Int -> (Instr, Int)
execute "acc" x = (1, x)
execute "jmp" x = (x, 0)
execute "nop" x = (1, 0)

fsm :: [(String, Int)] -> [Instr] -> Int -> Instr -> (Bool, Int)
fsm instr seen acc n
  | n `elem` seen = (False, acc)
  | n == length instr = (True, acc)
  | otherwise   = fsm instr (n:seen) (acc + inc) (n + delta)
  where
    (delta, inc) = uncurry execute (instr !! n)

alter :: [(String, Int)] -> (String, Int) -> [(String, Int)] -> (Bool, Int)
alter used ("jmp", x) instr = fsm (used ++ [("nop",x)] ++ instr) [] 0 0
alter used ("nop", x) instr = fsm (used ++ [("jmp",x)] ++ instr) [] 0 0
alter used (i, x) instr = (False, 0)

fixer :: [(String, Int)] -> (String, Int) -> [(String, Int)] -> Int
fixer used cmd instr
  | sucess    = acc
  | otherwise = fixer (used ++ [cmd]) (head instr) (tail instr)
  where
    (sucess, acc) = alter used cmd instr

toNum :: String -> Int
toNum ('+':s) = toNum s
toNum s       = read s :: Int

toTuple :: [String] -> (String, Int)
toTuple [x,y] = (x, toNum y)

readInstr :: String -> [(String, Int)]
readInstr = map (toTuple . splitOn " ") . lines

main :: IO ()
main = do
  -- handler <- openFile "test/2020/day08.txt" ReadMode
  handler <- openFile "input/2020/day08.txt" ReadMode
  contents <- hGetContents handler
  let instructions = readInstr contents
  print (snd $ fsm instructions [] 0 0)
  print (fixer [] (head instructions) (tail instructions))
  hClose handler
