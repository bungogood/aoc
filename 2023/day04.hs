import System.IO
import Data.List.Split (splitOn)
import Data.List (intersect)

type Card = (Int, [Int], [Int])

toNum :: String -> Int
toNum = read

toCard :: String -> Card
toCard s = (gid, map toNum $ words wn, map toNum $ words bn)
  where
    [game, rest] = splitOn ":" s
    [wn, bn] = splitOn "|" rest
    gid = toNum . last . words $ game

dups :: Card -> [Int]
dups (gid, wn, bn) = wn `intersect` bn

dupsPow :: Int -> Card -> Int
dupsPow base card = if count == 0 then 0 else base ^ (count - 1)
  where count = length $ dups card

decrement :: [(Int, Int)] -> [(Int, Int)]
decrement pairs = [(r - 1, o) | (r, o) <- pairs, r > 1]

countCards :: [Card] -> Int
countCards cards = fst . foldl cont (0, []) $ map (length . dups) cards
  where
    instances = (+1) . sum . map snd
    cont (acc, ls) n = (acc + instances ls, occs n ls)
    occs n os = if n > 0 then (n, instances os):decrement os else decrement os

main :: IO ()
main = do
  contents <- readFile "input/day04.txt"
  let cards = map toCard . lines $ contents
  print $ sum $ map (dupsPow 2) cards
  print $ countCards cards
