import System.IO
import Data.Char (isDigit)
import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.Set as Set

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

splitter :: [(Coord, Item)] -> (Map Coord Char, Map Coord (Coord, Int))
splitter = foldl (\(sym, nums) item -> case item of
    ((x, y), Symbol c) -> (Map.insert (x, y) c sym, nums)
    ((x, y), Number s) -> (sym, foldl (\a k -> Map.insert k idf a) nums locs)
      where
        idf = ((x, y), toNum s)
        locs = [(x', y) | x' <- [x..x + length s - 1]]
  ) (Map.empty, Map.empty)

neighbours :: Coord -> [Coord]
neighbours (x, y) = [(x + dx, y + dy) | dx <- [-1, 0, 1], dy <- [-1, 0, 1], dx /= 0 || dy /= 0]

validNumberSum :: Map Coord Char -> Map Coord (Coord, Int) -> Int
validNumberSum sym nums = sum . Set.map snd . foldl ttt Set.empty $ Map.keys sym
  where 
    ttt acc = foldl (nearComb nums) acc . neighbours
    nearComb m acc n = case Map.lookup n m of
          Just v -> Set.insert v acc
          Nothing -> acc

tmp s (Just v) = Set.insert v s
tmp s Nothing = s

charCoords :: Char -> Map Coord Char -> [Coord]
charCoords c = Map.keys . Map.filter (== c)

numNearProd :: Map Coord (Coord, Int) -> Coord -> Set.Set Int
numNearProd cs = Set.map snd . foldl (nearComb cs) Set.empty . neighbours
  where nearComb m acc n = case Map.lookup n m of
          Just v -> Set.insert v acc
          Nothing -> acc

prodNearChar :: Map Coord (Coord, Int) -> Char -> Map Coord Char -> [Set.Set Int]
prodNearChar cs c = filter (\ls -> length ls == 2) . map (numNearProd cs) . charCoords c

main :: IO ()
main = do
  -- handler <- openFile "test/2023/day03.txt" ReadMode
  handler <- openFile "input/2023/day03.txt" ReadMode
  contents <- hGetContents handler
  let tokens = toItems $ lines contents
  let (sym, nums) = splitter tokens
  print (sum $ validNumberSum sym nums)
  print (sum . map product $ prodNearChar nums '*' sym)
  hClose handler
