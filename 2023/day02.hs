import System.IO
import Data.List.Split (splitOn)
import Data.List (foldl')
import Data.Map (Map)
import qualified Data.Map as Map

-- https://adventofcode.com/2023/day/2

type Game = (Int, [Round])
type Round = [(String, Int)]

toNum :: String -> Int
toNum = read

toGame :: String -> Game
toGame vs = let [game, rest] = splitOn ":" vs
                gid = toNum . last . words
                rounds = map (map toPair . splitOn ",") . splitOn ";"
                toPair s = let [count, cube] = words s in (cube, toNum count)
            in (gid game, rounds rest)

under :: Map String Int -> Map String Int -> Bool
under limits = all (\(cube, count) -> count <= Map.findWithDefault 0 cube limits) . Map.toList

most :: [Round] -> Map String Int
most = foldl' (foldl' (\acc (cube, count) -> Map.insertWith max cube count acc)) Map.empty

allUnderSumID :: Map String Int -> [Game] -> Int
allUnderSumID limits = sum . map (\(gid, rounds) -> if under limits (most rounds) then gid else 0)

sumProduct :: [Game] -> Int
sumProduct = sum . map (product . Map.elems . most . snd)

main :: IO ()
main = do
  -- handler <- openFile "test/2023/day02.txt" ReadMode
  handler <- openFile "input/2023/day02.txt" ReadMode
  contents <- hGetContents handler
  let values = map toGame $ lines contents
  print (allUnderSumID (Map.fromList [("red", 12), ("green", 13), ("blue", 14)]) values)
  print (sumProduct values)
  hClose handler
