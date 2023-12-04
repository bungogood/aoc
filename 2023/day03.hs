import System.Environment (getArgs)
import System.IO (readFile)
import Data.Char (isDigit)
import Data.Map (Map)
import qualified Data.Map as Map

-- https://adventofcode.com/2023/day/3

type Coord = (Int, Int)
data Item = Symbol Char | Number String deriving (Show, Eq)

toNum :: String -> Int
toNum = read

toNumber :: Coord -> String -> [(Coord, Item)]
toNumber (x, y) [] = []
toNumber (x, y) rev = [((x - length rev, y), Number (reverse rev))]

toItems :: [String] -> [(Coord, Item)]
toItems (r:rs) = toItemsRec (0, 0) [] r rs

toItemsRec :: Coord -> String -> String -> [String] -> [(Coord, Item)]
toItemsRec (x, y) acc [] [] = toNumber (x, y) acc
toItemsRec (x, y) acc [] (r:rs) = toNumber (x, y) acc ++ toItemsRec (0, y + 1) [] r rs
toItemsRec (x, y) acc (c:cs) rs
  | c == '.' = remaining
  | isDigit c = toItemsRec (x + 1, y) (c:acc) cs rs
  | otherwise = ((x, y), Symbol c) : remaining
  where
    remaining = toNumber (x, y) acc ++ toItemsRec (x + 1, y) [] cs rs

splitter :: [(Coord, Item)] -> (Map Coord Char, [([Coord], Int)])
splitter = foldl (\(sym, nums) item -> case item of
    ((x, y), Symbol c) -> (Map.insert (x, y) c sym, nums)
    ((x, y), Number s) -> let coords = [(x', y) | x' <- [x..x + length s - 1]]
                          in (sym, (coords, toNum s) : nums)
  ) (Map.empty, [])

neighbours :: Coord -> [Coord]
neighbours (x, y) = [(x + dx, y + dy) | dx <- [-1, 0, 1], dy <- [-1, 0, 1], dx /= 0 || dy /= 0]

isHitSym :: Map Coord Char -> ([Coord], Int) -> Bool
isHitSym sym = any (symAdj sym) . fst
  where symAdj sym = any (`Map.member` sym) . neighbours

validNumberSum :: Map Coord Char -> [([Coord], Int)] -> Int
validNumberSum sym = sum . map snd . filter (isHitSym sym)

charCoords :: Char -> Map Coord Char -> [Coord]
charCoords c = Map.keys . Map.filter (== c)

numNearProd :: [([Coord], Int)] -> Coord -> Int
numNearProd nums tar = case map snd $ filter (isAdj . fst) nums of
    [a, b] -> a * b
    _ -> 0
  where isAdj coords = any (`elem` coords) (neighbours tar)

prodNearChar :: [([Coord], Int)] -> Char -> Map Coord Char -> Int
prodNearChar cs c = sum . map (numNearProd cs) . charCoords c

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let tokens = toItems $ lines contents
  let (sym, nums) = splitter tokens
  print (validNumberSum sym nums)
  print (prodNearChar nums '*' sym)
