#!/bin/bash

# Usage: ./runner.sh year day [-t]

YEAR=$1
DAY=$(printf "%02d" $2)  # Pad day with leading zero if necessary
FLAG=${3:-}  # Optional third argument for test flag

case $FLAG in
  -t)
    INPUT_FILE="test/$YEAR/day$DAY.txt"
    ;;
  *)
    INPUT_FILE="input/$YEAR/day$DAY.txt"
    ;;
esac

runghc $YEAR/day$DAY.hs $INPUT_FILE
