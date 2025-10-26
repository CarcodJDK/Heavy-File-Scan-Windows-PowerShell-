<#
Author
Carlos Cabrera
Date: 26/10/2025
.SYNOPSIS
  Scan for very large files on Windows and export results to CSV (optional).

.DESCRIPTION
  Recursively scans a path looking for files larger than a given size (in GB).
  Allows exclusions, Top-N results, and optional CSV export.

.PARAMETER Path
  Root path to analyze (default: C:\).

.PARAMETER MinSizeGB
  Minimum file size (in GB). Default: 1.

.PARAMETER Output
  Optional CSV path. If omitted, results are printed to console only.

.PARAMETER Top
  Show only the Top-N largest files (default: all).

.PARAMETER Exclude
  One or more regex patterns for folder paths to exclude
  (e.g. 'Windows','Program Files','ProgramData').

.EXAMPLE
  .\HeavyFileScan.ps1 -Path C:\ -MinSizeGB 2 -Top 50 -Output "$env:USERPROFILE\Desktop\Large_Files.csv" -Exclude 'Windows','Program Files','ProgramData'
#>

[CmdletBinding()]
param(
    [string]$Path = "C:\",
    [double]$MinSizeGB = 1,
    [string]$Output,
    [int]$Top,
    [string[]]$Exclude
)

Write-Host "=== Heavy File Scan ===" -ForegroundColor Cyan
Write-Host "Path: $Path | MinSizeGB: $MinSizeGB" -ForegroundColor Cyan
if ($Exclude) { Write-Host "Excluding (regex): $($Exclude -join ', ')" -ForegroundColor DarkCyan }

# Build size in bytes
$minBytes = [math]::Round($MinSizeGB * 1GB)

# Get items with progress
$items = Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue

$results = foreach ($i in $items) {
    if ($Exclude) {
        $dir = $i.DirectoryName
        if ($Exclude | Where-Object { $dir -match $_ }) { continue }
    }
    if ($i.Length -ge $minBytes) {
        [PSCustomObject]@{
            FullName   = $i.FullName
            LastWrite  = $i.LastWriteTime
            "Size(GB)" = [math]::Round($i.Length / 1GB, 2)
        }
    }
}

if ($Top -gt 0) {
    $results = $results | Sort-Object "Size(GB)" -Descending | Select-Object -First $Top
} else {
    $results = $results | Sort-Object "Size(GB)" -Descending
}

if (-not $results) {
    Write-Warning "No files >= $MinSizeGB GB were found."
    return
}

$results | Format-Table -AutoSize

if ($Output) {
    $dir = Split-Path $Output -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    $results | Export-Csv -Path $Output -NoTypeInformation -Encoding UTF8
    Write-Host "`nResults saved to: $Output" -ForegroundColor Green
}