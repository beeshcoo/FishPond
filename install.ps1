<#
RingPond skill installer (Windows / PowerShell)
Installs to ~/.claude/skills/ringpond/ or ~/.cursor/skills/ringpond/
Usage:
  ./install.ps1
  ./install.ps1 -Target both
  ./install.ps1 -Project C:\path\to\project
#>
param(
  [ValidateSet('claude','cursor','both')] [string]$Target = 'claude',
  [string]$Project = ''
)

$ErrorActionPreference = 'Stop'
$src = $PSScriptRoot
if (-not (Test-Path (Join-Path $src 'SKILL.md'))) { throw "SKILL.md not found in $src" }

function Install-To($dir) {
  $dest = Join-Path $dir 'ringpond'
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
  Get-ChildItem $src -Force | Where-Object { $_.Name -ne '.git' } | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $dest $_.Name) -Recurse -Force
  }
  Write-Host ('Installed RingPond -> ' + $dest) -ForegroundColor Green
}

$homeDir = $HOME
if ($Target -in 'claude','both') { Install-To (Join-Path $homeDir '.claude\skills') }
if ($Target -in 'cursor','both') { Install-To (Join-Path $homeDir '.cursor\skills') }

if ($Project -ne '') {
  if (-not (Test-Path (Join-Path $Project '.git'))) { throw "Not a git repo: $Project" }
  $hookDir = Join-Path $Project '.githooks'
  New-Item -ItemType Directory -Force -Path $hookDir | Out-Null
  Copy-Item (Join-Path $src 'enforcement\pre-commit') (Join-Path $hookDir 'pre-commit') -Force
  git -C $Project config core.hooksPath .githooks
  Write-Host ('pre-commit installed in ' + $Project) -ForegroundColor Green
  $fp = Join-Path $Project '.fishpond'
  New-Item -ItemType Directory -Force -Path $fp | Out-Null
  $verify = Join-Path $fp 'verify.ps1'
  if (-not (Test-Path $verify)) {
    Copy-Item (Join-Path $src 'enforcement\verify.example.ps1') $verify -Force
    Write-Host 'Created .fishpond/verify.ps1 - fill in build/test commands' -ForegroundColor Yellow
  }
}

Write-Host 'Done. Restart Claude Code. Trigger: RingPond / FishPond / quanyu' -ForegroundColor Cyan
