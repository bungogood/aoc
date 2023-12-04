#!/bin/bash

# Usage: ./fetch.sh year [day]
# Usage for entire year: ./fetch.sh -a year

if [ -f .env ]; then
    export $(cat .env | xargs)
fi

ALL_DAYS=false

# Check for the -a option
if [ "$1" == "-a" ]; then
    ALL_DAYS=true
    shift
fi

# Function to download input for a given day
download_day() {
    YEAR=$1
    DAY=$(printf "%02d" $2)  # Pad day with leading zero
    URL="https://adventofcode.com/$YEAR/day/${DAY#0}/input"  # Remove leading zero for URL
    FILE="$DIR/day$DAY.txt"

    curl -s -b session=$SESSION $URL --output $FILE

    echo "Downloaded $YEAR ${DAY#0} to $FILE"
}

YEAR=$1
DIR="input/$YEAR"

# Check if the required directories exist, create if not
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
fi

# Download data for all days or a single day
if [ "$ALL_DAYS" == "true" ]; then
    for DAY in {1..25}; do
        download_day $YEAR $DAY
    done
else
    DAY=$2
    download_day $YEAR $DAY
fi
