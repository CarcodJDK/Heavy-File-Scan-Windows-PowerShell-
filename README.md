<h1 align="center">🧠 Heavy File Scan — Windows PowerShell</h1>

<p align="center">
  <b>Find huge files on your Windows drives, fast.</b><br>
  Scan directories recursively, filter by size, and export results to CSV — perfect for cleaning disks or auditing assets.
</p>

<p align="center">
  <a href="https://github.com/yourusername/Heavy-File-Scan-Windows-PowerShell">
    <img src="https://img.shields.io/badge/PowerShell-blue?logo=powershell&logoColor=white" alt="PowerShell">
  </a>
  <img src="https://img.shields.io/badge/license-MIT-green" alt="MIT License">
  <img src="https://img.shields.io/github/last-commit/yourusername/Heavy-File-Scan-Windows-PowerShell" alt="Last Commit">
</p>

---

## ✨ Features
- ⚙️ **Filter by minimum size (GB)**
- 📊 **Export to CSV** for Excel / BI tools
- 🚀 **Optional Top-N** largest files
- 🧩 **Exclude system folders** using regex (e.g. `Windows`, `Program Files`)
- 🔒 **Safe scanning** — silently skips permission errors

---

## 🚀 Quick Start

```powershell
# Run from the repo root
pwsh -File .\scripts\HeavyFileScan.ps1 -Path C:\ -MinSizeGB 1 -Top 50 -Output "$env:USERPROFILE\Desktop\Large_Files.csv" -Exclude 'Windows','Program Files','ProgramData'

# Only print results to console
.\scripts\HeavyFileScan.ps1 -Path D:\Data -MinSizeGB 2

# Export CSV + exclude noisy folders
.\scripts\HeavyFileScan.ps1 -Path C:\ -MinSizeGB 1 -Output "$env:USERPROFILE\Desktop\Large_Files.csv" -Exclude 'Windows','Program Files','ProgramData'

# Top 20 largest files on C:\
.\scripts\HeavyFileScan.ps1 -Top 20
