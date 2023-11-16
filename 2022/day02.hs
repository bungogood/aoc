import System.IO  
import Control.Monad
import Data.List.Split
import Data.List

-- https://adventofcode.com/2022/day/2

data Symbol = Rock | Paper | Scissors deriving (Eq, Show)

beats :: Symbol -> Symbol
beats Rock     = Paper
beats Paper    = Scissors
beats Scissors = Rock

losses :: Symbol -> Symbol
losses = beats . beats

shapePoints :: Symbol -> Int
shapePoints Rock     = 1
shapePoints Paper    = 2
shapePoints Scissors = 3

outcomePoints :: Symbol -> Symbol -> Int
outcomePoints x y | beats x == y = 6 -- win
                  | x == beats y = 0 -- loss
                  | otherwise = 3    -- draw

game :: Symbol -> Symbol -> Int
game x y = outcomePoints x y + shapePoints y

points :: [(Symbol, Symbol)] -> Int
points = sum . map (uncurry game)

mapSymbol :: Char -> Symbol
mapSymbol 'X' = Rock
mapSymbol 'Y' = Paper
mapSymbol 'Z' = Scissors
mapSymbol 'A' = Rock
mapSymbol 'B' = Paper
mapSymbol 'C' = Scissors

symbolMap :: (Symbol, Char) -> (Symbol, Symbol)
symbolMap (x, y) = (x, mapSymbol y)

outcomeMap :: (Symbol, Char) -> (Symbol, Symbol)
outcomeMap (x, 'X') = (x, losses x)
outcomeMap (x, 'Y') = (x, x)
outcomeMap (x, 'Z') = (x, beats x)

toGame :: String -> [(Symbol, Char)]
toGame = map (tuplify . map head . splitOn " ") . lines
  where
    tuplify :: [Char] -> (Symbol, Char)
    tuplify [x,y] = (mapSymbol x, y)

main = do
  handler <- openFile "input/day02.txt" ReadMode
  contents <- hGetContents handler
  let symbols = toGame contents
  print ((points . map symbolMap) symbols)
  print ((points . map outcomeMap) symbols)
  hClose handler
