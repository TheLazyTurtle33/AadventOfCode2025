param(
    [Parameter(Mandatory=$true)]
    [int]$Day
)

if ($Day -lt 1 -or $Day -gt 25) {
    Write-Error "Day must be between 1 and 25."
    exit 1
}

$dayStr = "{0:D2}" -f $Day
$folder = "src/day$dayStr"
$file   = "$folder/main.zig"

if (-not (Test-Path $folder)) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
    Write-Host "Created folder: $folder"
} else {
    Write-Host "Folder already exists: $folder"
}

if (-not (Test-Path $file)) {
    @"
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Advent of Code - Day $Day\n", .{});

    // TODO: implement solution for day $Day
}
"@ | Out-File -FilePath $file -Encoding UTF8 -Force

    Write-Host "Created file: $file"
} else {
    Write-Host "File already exists: $file"
}

Write-Host "Day $Day is ready!"
