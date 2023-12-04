#!/bin/bash

# Usage: ./fetch.sh year day

if [ -f .env ]; then
    export $(cat .env | xargs)
fi

YEAR=$1
DAY=$(printf "%02d" $2)  # Pad day with leading zero if necessary
URL="https://adventofcode.com/$YEAR/day/${DAY#0}/input"  # Remove leading zero for URL
DIR="input/$YEAR"
FILE="$DIR/day$DAY.txt"

# Check if the required directories exist, create if not
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
fi

# Use curl to download the file
# Replace {SESSION} with your actual session token from Advent of Code request headers
curl -s -b session=$SESSION $URL --output $FILE

echo "Downloaded input for Year $YEAR, Day ${DAY#0} to $FILE"
