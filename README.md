# Heavy-File-Scan-Windows-PowerShell-
Scan your Windows drives for **very large files** and (optionally) export the results to CSV, sorted by size.   Works great for freeing space, auditing game assets, ISOs, VM disks, etc.
## ✨ Features
- Filter by **minimum size (GB)**
- Optional **Top-N** largest files
- **Exclude** system folders via regex (e.g., `Windows`, `Program Files`)
- **CSV export** for Excel / BI tools
- Safe: ignores permission errors

## 🚀 Quick start
```powershell
# Run from repo root
pwsh -File .\scripts\HeavyFileScan.ps1 -Path C:\ -MinSizeGB 1 -Top 50 -Output "$env:USERPROFILE\Desktop\Large_Files.csv" -Exclude 'Windows','Program Files','ProgramData'

# Only print results to console
.\scripts\HeavyFileScan.ps1 -Path D:\Data -MinSizeGB 2

# Export CSV + exclude noisy folders
.\scripts\HeavyFileScan.ps1 -Path C:\ -MinSizeGB 1 -Output "$env:USERPROFILE\Desktop\Large_Files.csv" -Exclude 'Windows','Program Files','ProgramData'

# Top 20 largest files on C:\
.\scripts\HeavyFileScan.ps1 -Top 20
