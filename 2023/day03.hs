import System.IO
import Data.Char (isDigit)
import Data.Map (Map)
import qualified Data.Map as Map

-- https://adventofcode.com/2023/day/3

type Coord = (Int, Int)
data Item = Symbol Char | Number String deriving (Show, Eq)

toNum :: String -> Int
toNum = read

toItems :: [String] -> [(Coord, Item)]
toItems (r:rs) = toItemsRec (0, 0) [] r rs

toItemsRec :: Coord -> String -> String -> [String] -> [(Coord, Item)]
toItemsRec (x, y) acc [] (r:rs) = [((x - length acc, y), Number acc) | not (null acc)] ++ toItemsRec (0, y + 1) [] r rs
toItemsRec (x, y) acc ('.':cs) rs = [((x - length acc, y), Number acc) | not (null acc)] ++ toItemsRec (x + 1, y) [] cs rs
toItemsRec (x, y) acc (c:cs) rs
  | isDigit c = toItemsRec (x + 1, y) (acc ++ [c]) cs rs
  | otherwise = addr ++ ((x, y), Symbol c) : toItemsRec (x + 1, y) [] cs rs
  where addr = [((x - length acc, y), Number acc) | not (null acc)]
toItemsRec (x, y) acc _ [] = [((x - length acc, y), Number acc) | not (null acc)]

splitter :: [(Coord, Item)] -> (Map Coord Char, [([Coord], Int)])
splitter = foldl (\(sym, res) ((x, y), item) -> case item of
    Symbol c -> (Map.insert (x, y) c sym, res)
    Number s -> (sym, ([(x', y) | x' <- [x..x - 1 + length s]], toNum s) : res)
  ) (Map.empty, [])

adjactent :: Map Coord Char -> Coord -> Bool
adjactent sym = any (\(x', y') -> Map.member (x', y') sym) . adj

isHit :: Map Coord Char -> ([Coord], Int) -> Bool
isHit sym (cs, n) = any (adjactent sym) cs

validNumberSum :: Map Coord Char -> [([Coord], Int)] -> Int
validNumberSum sym = sum . map snd . filter (isHit sym)

charCoords :: Char -> Map Coord Char -> [Coord]
charCoords c = Map.keys . Map.filter (== c)

numNearProd :: [([Coord], Int)] -> Coord -> Int
numNearProd cs t = if length near == 2 then product near else 0
  where near = map snd $ filter (\(c, _) -> any (`elem` c) (adj t)) cs

prodNearChar :: Map Coord Char -> [([Coord], Int)] -> Char -> Int
prodNearChar sym cs c = sum . map (numNearProd cs) $ charCoords c sym

adj :: Coord -> [Coord]
adj (x, y) = [
    (x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
    (x - 1, y), (x + 1, y),
    (x - 1, y + 1), (x, y + 1), (x + 1, y + 1)
  ]

main :: IO ()
main = do
  handler <- openFile "input/day03.txt" ReadMode
  contents <- hGetContents handler
  let tokens = toItems $ lines contents
  let (sym, nums) = splitter tokens
  print (validNumberSum sym nums)
  print (prodNearChar sym nums '*')
  hClose handler

testCase :: ([String], [Int])
testCase = ([
    "467..114..",
    "...*......",
    "..35..633.",
    "......#...",
    "617*......",
    ".....+.58.",
    "..592.....",
    "......755.",
    "...$.*....",
    ".664.598.."
  ], [114, 58])
