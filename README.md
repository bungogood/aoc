# Advent of Code

This repository contains my solutions for the [Advent of Code](https://adventofcode.com) (AoC) puzzles, written in Haskell. Advent of Code is an annual series of Christmas-themed programming puzzles presented like an advent calendar. Each day's challenge is solved in a separate Haskell file, organized within directories named for each year (`[year]`).

## Running Solutions

Storing the input in a file named for the day in `[year]/input/day[day].hs` in the same directory as the

```
cd year
runghc day[day].hs
```

## Progress

| Year | Progress |
| ---- | -------- |
| 2022 | 5/25     |
| 2021 | 1/25     |
| 2020 | 1/25     |
| 2019 | 1/25     |
| 2018 | 0/25     |
| 2017 | 0/25     |
| 2016 | 0/25     |
| 2015 | 0/25     |

## Packages

Install Haskell dependencies using Cabal:

```
cabal install --lib [module]
```

Cabal packages:

-   `split`
-   `QuickCheck`

## Clean Up

Remove all untracked files with:

```
git clean -xdf
```

## References

-   [Advent of Code](https://adventofcode.com)
