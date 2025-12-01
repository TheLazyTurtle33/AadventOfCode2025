#!/usr/bin/env bash

# Exit on errors
set -e

if [ -z "$1" ]; then
    echo "Usage: ./new-day.sh <day>"
    exit 1
fi

DAY="$1"

# Check range 1–25
if [ "$DAY" -lt 1 ] || [ "$DAY" -gt 25 ]; then
    echo "Day must be between 1 and 25."
    exit 1
fi

# Zero-pad day number (e.g., 1 → 01)
DAY_STR=$(printf "%02d" "$DAY")

FOLDER="src/day$DAY_STR"
FILE="$FOLDER/main.zig"

# Create folder if needed
if [ ! -d "$FOLDER" ]; then
    mkdir -p "$FOLDER"
    echo "Created folder: $FOLDER"
else
    echo "Folder already exists: $FOLDER"
fi

# Create main.zig if needed
if [ ! -f "$FILE" ]; then
cat << EOF > "$FILE"
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Advent of Code - Day $DAY\n", .{});

    // TODO: implement solution for day $DAY
}
EOF

    echo "Created file: $FILE"
else
    echo "File already exists: $FILE"
fi

echo "Day $DAY is ready!"
