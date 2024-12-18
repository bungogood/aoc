import Crypto.Hash (Digest, MD5, hash)
import Data.ByteArray.Encoding (Base (Base16), convertToBase)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as C
import System.Environment (getArgs)
import System.IO (readFile)

-- https://adventofcode.com/2015/day/4

md5Hash :: ByteString -> ByteString
md5Hash input = convertToBase Base16 (hash input :: Digest MD5)

match :: ByteString -> ByteString -> Bool
match prefix input = C.isPrefixOf prefix (md5Hash input)

matcher :: ByteString -> String -> Int
matcher prefix input = head [i | i <- [1 ..], match prefix (C.pack (input ++ show i))]

finder :: Int -> String -> Int
finder n = matcher (C.pack (replicate n '0'))

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let input = head (lines contents)
  print (finder 5 input)
  print (finder 6 input)
