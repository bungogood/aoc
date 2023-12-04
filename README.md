# Advent of Code

This repository contains my solutions for the [Advent of Code](https://adventofcode.com) (AoC) puzzles, written in Haskell. Advent of Code is an annual series of Christmas-themed programming puzzles presented like an advent calendar. Each day's challenge is solved in a separate Haskell file, organized within directories named for each year.

## Running Solutions

Use the `run` script. By default, it runs with the input file located at `input/[year]/day[day].txt`. Options include `-t` to use the test file instead, or `-f` followed by a specific file path to use a different input file:

```bash
./run.sh year day [-t] [-f input-file]
```

Alternatively, run the solutions directly with:

```bash
runghc [year]/day[day].hs input/[year]/day[day].txt
```

## Progress

| Year | Progress |
| ---- | -------- |
| 2023 | 4/25     |
| 2022 | 5/25     |
| 2021 | 1/25     |
| 2020 | 1/25     |
| 2019 | 1/25     |
| 2018 | 1/25     |
| 2017 | 1/25     |
| 2016 | 0/25     |
| 2015 | 6/25     |

## Packages

Install Haskell dependencies using Cabal:

```bash
cabal install --lib [module]
```

Cabal packages:

-   `cryptonite`
-   `memory`
-   `split`
-   `QuickCheck`

## Fetching Input

The input for each day is saved in `input/[year]/day[day].txt`. Use the `fetch` script, with the AoC session token either set in a `.env` file or as an environment variable, to download input for individual days or the entire year:

```bash
./fetch.sh year [day]
```

## Clean Up

Remove all untracked files with:

```bash
git clean -xdf
```

## References

-   [Advent of Code](https://adventofcode.com)
-   [Haskell](https://www.haskell.org)
