import System.Environment (getArgs)
import System.IO (readFile)
import qualified Data.Map as M

-- https://adventofcode.com/2023/day/8

type Node = String
type Instr = Char
type Graph = M.Map Node (Node, Node)

toNode :: String -> (Node, (Node, Node))
toNode x = (node, (left, right))
    where
        [node, "=", left', right'] = words x
        left = init $ tail left'
        right = init right'

parse :: String -> (Graph, [Instr])
parse x = (graph, instr)
    where
        (instr:_:edges) = lines x
        graph = M.fromList . map toNode $ edges

next :: Graph -> Node -> Instr -> Node
next graph node 'L' = fst $ graph M.! node
next graph node 'R' = snd $ graph M.! node

-- Part 1
walker :: Graph -> Node -> [Instr] -> [Instr] -> Int -> Int
walker graph "ZZZ" _ _ count = count
walker graph node (i:is) r count = walker graph (next graph node i) is r (count + 1)
walker graph node [] r count = walker graph node r r count

solve :: Graph -> Node -> [Instr] -> Int
solve graph node r = walker graph node r r 0

-- Part 2
terminal :: Node -> Bool
terminal = (== 'Z') . last

start :: Node -> Bool
start = (== 'A') . last

walker' :: Graph -> [Instr] -> [Instr] -> Int -> Node -> Int
walker' graph (i:is) r count node
    | terminal node = count
    | otherwise = walker' graph is r (count + 1) (next graph node i)
walker' graph [] r count node = walker' graph r r count node

multi :: Graph -> [Instr] -> [Node] -> Int
multi graph r = foldr (lcm . walker' graph r r 0) 1

main :: IO ()
main = do
  args <- getArgs
  contents <- readFile (head args)
  let (graph, instr) = parse contents
  print $ solve graph "AAA" instr
  print $ multi graph instr $ filter start (M.keys graph)
