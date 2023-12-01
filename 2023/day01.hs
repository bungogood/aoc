import System.IO
import Data.List (find, isPrefixOf)
import Data.Char (isDigit)
import Control.Applicative ((<|>))

-- https://adventofcode.com/2023/day/1

toNum :: String -> Int
toNum s = read s :: Int

pairs :: [(String, Char)]
pairs = [
    ("zero", '0'),
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

extractor :: (String -> Maybe Char) -> String -> [Char]
extractor f [] = []
extractor f (x:xs) = case f (x:xs) of
    Just d -> d : rest
    Nothing -> rest
    where rest = extractor f xs

firstLast :: (String -> Maybe Char) -> String -> Int
firstLast f s = do
    let digits = extractor f s
    toNum [head digits, last digits]

digit :: String -> Maybe Char
digit (x:_) | isDigit x = Just x
digit _ = Nothing

both :: String -> Maybe Char
both s = digit s <|> numPrefix s

main :: IO ()
main = do
  handler <- openFile "input/day01.txt" ReadMode
  contents <- hGetContents handler
  let values = lines contents
  print (sum $ map (firstLast digit) values)
  print (sum $ map (firstLast both) values)
  hClose handler

testCases1 :: [(String, Maybe Int)]
testCases1 = [
    ("1abc2", Just 12),
    ("pqr3stu8vwx", Just 38),
    ("a1b2c3d4e5f", Just 15),
    ("treb7uchet", Just 77)
  ]

testCases2 :: [(String, Maybe Int)]
testCases2 = [
    ("two1nine", Just 29),
    ("eightwothree", Just 83),
    ("abcone2threexyz", Just 13),
    ("xtwone3four", Just 24),
    ("4nineeightseven2", Just 42),
    ("zoneight234", Just 14),
    ("7pqrstsixteen", Just 76)
  ]
