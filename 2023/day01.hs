import Control.Applicative ((<|>))
import Data.Char (isDigit)
import Data.List (find, isPrefixOf)
import Data.Maybe (mapMaybe)
import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2023/day/1

toNum :: String -> Int
toNum s = read s :: Int

pairs :: [(String, Char)]
pairs =
  [ ("zero", '0'),
    ("one", '1'),
    ("two", '2'),
    ("three", '3'),
    ("four", '4'),
    ("five", '5'),
    ("six", '6'),
    ("seven", '7'),
    ("eight", '8'),
    ("nine", '9')
  ]

numPrefix :: String -> Maybe Char
numPrefix s = snd <$> find (flip isPrefixOf s . fst) pairs

findFirst :: ([a] -> Maybe b) -> [a] -> Maybe b
findFirst _ [] = Nothing
findFirst f (x : xs) = f (x : xs) <|> findFirst f xs

findLast :: ([a] -> Maybe b) -> [a] -> Maybe b
findLast f xs = walk f [] (reverse xs)
  where
    walk :: ([a] -> Maybe b) -> [a] -> [a] -> Maybe b
    walk _ _ [] = Nothing
    walk f acc (x : xs) = f (x : acc) <|> walk f (x : acc) xs

firstLast :: (String -> Maybe Char) -> String -> Maybe Int
firstLast f s = do
  firstDigit <- findFirst f s
  lastDigit <- findLast f s
  Just (toNum [firstDigit, lastDigit])

digit :: String -> Maybe Char
digit (x : _) | isDigit x = Just x
digit _ = Nothing

both :: String -> Maybe Char
both s = digit s <|> numPrefix s

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let values = lines contents
  print (sum $ mapMaybe (firstLast digit) values)
  print (sum $ mapMaybe (firstLast both) values)
