import Data.Bifunctor (first)
import Data.List.Split (splitOn)
import Data.Map (Map)
import Data.Map qualified as Map
import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2023/day/5

type Inter = (Int, Int, Int)

toNum :: String -> Int
toNum = read

toInter :: [String] -> [Inter]
toInter = map (interval . map toNum . words)
  where
    interval [d, s, l] = (d, s, s + l - 1)

splitTop :: String -> (String, String)
splitTop s = (src, dest)
  where
    [src, dest] = splitOn "-to-" . head $ words s

parse :: String -> ([Int], [((String, String), [Inter])])
parse s = (seeds, ls)
  where
    (header : all) = splitOn "\n\n" s
    [_, sss] = splitOn ":" header
    seeds = map toNum $ words sss
    ls = map (yyy . lines) all
    yyy (top : rest) = (splitTop top, toInter rest)

createMap :: [((String, String), [Inter])] -> Map String [Inter]
createMap = Map.fromList . map (Data.Bifunctor.first snd)

toOrder :: [((String, String), [Inter])] -> Map String String
toOrder = Map.fromList . map fst

breakup :: Inter -> (Int, Int) -> [(Int, Int)]
breakup (d, s, e) (a, b)
  | a < s && b < s || a > e && b > e = [(a, b)]
  | otherwise = start ++ mid ++ end
  where
    start = [(a, s - 1) | a < s]
    mid = [(max a s, min b e)]
    end = [(e + 1, b) | b > e]

mover :: [Inter] -> [(Int, Int)] -> [(Int, Int)]
mover is = foldl (\rs' r -> move is r : rs') []

move :: [Inter] -> (Int, Int) -> (Int, Int)
move [] (a, b) = (a, b)
move (i : is) (a, b)
  | a < s && b < s || a > e && b > e = move is (a, b)
  | otherwise = (a - s + d, b - s + d)
  where
    (d, s, e) = i

nextRanges :: [Inter] -> [(Int, Int)] -> [(Int, Int)]
nextRanges is rs = mover is $ foldl (\a i -> concatMap (breakup i) a) rs is

findResults :: Map String [Inter] -> Map String String -> String -> [(Int, Int)] -> [(Int, Int)]
findResults mi ms k vs = case Map.lookup k ms of
  Nothing -> vs
  Just next -> findResults mi ms next $ nextRanges (mi Map.! next) vs

toPairs :: [Int] -> [(Int, Int)]
toPairs [] = []
toPairs (s : l : rest) = (s, s + l - 1) : toPairs rest

toSingles :: [Int] -> [(Int, Int)]
toSingles = map (\x -> (x, x))

best :: Map String [Inter] -> Map String String -> String -> [(Int, Int)] -> Int
best mi ms k = minimum . map fst . findResults mi ms k

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let (seeds, input) = parse contents
  let order = toOrder input
  let mapping = createMap input
  print $ best mapping order "seed" $ toSingles seeds
  print $ best mapping order "seed" $ toPairs seeds
