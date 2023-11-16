# Advent of Code

This repository contains my solutions for the [Advent of Code](https://adventofcode.com) (AoC) puzzles, written in Haskell. Advent of Code is an annual series of Christmas-themed programming puzzles presented like an advent calendar. Each day's challenge is solved in a separate Haskell file, organized within directories named for each year (`[year]`).

## Running Solutions

Storing the input in a file named for the day in `[year]/input/day[day].hs` in the same directory as the

```
cd year
runghc day[day].hs
```

## Clean Up

Remove all untracked files with:

```
git clean -xdf
```

## Packages

Install Haskell dependencies using Cabal:

```
cabal install --lib [module]
```

Cabal packages:

-   `split`
-   `QuickCheck`

## References

-   [Advent of Code](https://adventofcode.com)
