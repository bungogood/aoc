import System.IO
import Crypto.Hash (MD5, Digest, hash)
import Data.ByteString (ByteString)
import Data.ByteArray.Encoding (Base(Base16), convertToBase)
import qualified Data.ByteString.Char8 as C

-- https://adventofcode.com/2015/day/4

md5Hash :: ByteString -> ByteString
md5Hash input = convertToBase Base16 (hash input :: Digest MD5)

match :: ByteString -> ByteString -> Bool
match prefix input = C.isPrefixOf prefix (md5Hash input)

matcher :: ByteString -> String -> Int
matcher prefix input = head [i | i <- [1..], match prefix (C.pack (input ++ show i))]

finder :: Int -> String -> Int
finder n = matcher (C.pack (replicate n '0'))

main :: IO ()
main = do
  -- handler <- openFile "test/2015/day04.txt" ReadMode
  handler <- openFile "input/2015/day04.txt" ReadMode
  contents <- hGetContents handler
  let input = head (lines contents)
  print (finder 5 input)
  print (finder 6 input)
  hClose handler
