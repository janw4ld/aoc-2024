{- HLINT ignore "Use map once" -}
module Main (main) where

import Control.Monad
import Data.Bifunctor
import Data.Char
import Data.Function
import Data.Functor
import Data.List
import Data.Maybe
import Data.Set qualified as S
import Debug.Trace

main = input >>= print . solve

input = readFile "./test-input"

-- input = readFile "./input"

solve = part1 . prepInput

part1 = id

part2 = id

prepInput = id

interleave a b = concat . transpose $ [a, b]
infixr 5 |||
(|||) = interleave

countOccurrences substr = length . filter (substr `isPrefixOf`) . tails

splitOn delim str
  | null str = [[]]
  | delim `isPrefixOf` str = [] : splitOn delim (drop (length delim) str)
  | otherwise =
      let (tl : rest) = splitOn delim (tail str)
       in (head str : tl) : rest

swap i' j' xs =
  if i' == j' then xs else left ++ [xs !! j] ++ middle ++ [xs !! i] ++ right
 where
  (i, j) = if i' > j' then (j', i') else (i', j')
  left = take i xs
  middle = take (j - i - 1) (drop (i + 1) xs)
  right = drop (j + 1) xs
groupByParity = \case
  [] -> ([], [])
  (x : xs) -> let (odds, evens) = groupByParity xs in (x : evens, odds)

consAdjacent = zipAdjacentWith (\a b -> [a, b])
markSignChanges = zipAdjacentWith (\x y -> x * y < 0)
diffEachTwo = zipAdjacentWith (-)
zipAdjacentWith f xs = zipWith f xs (drop 1 xs)
factorials = 1 : zipWith (*) factorials [1 ..]

toTuple [a, b] = (a, b)
fromTuple (a, b) = [a, b]
rotate n xs = take (length xs) $ drop n $ cycle xs
deleteAt n xs
  | n >= length xs = error "stop it, get help"
  | otherwise = take n xs <> drop (n + 1) xs
dupe = join (++)

trace1 v = trace (show v) v
infixl 0 |>
v |> f = f (trace1 v)
