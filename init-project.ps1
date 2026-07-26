<#
FishPond project initializer v2 - .fishpond/ + docs/ + hooks + git profile
Usage:
  ./init-project.ps1
  ./init-project.ps1 -Project C:\path\to\proj
#>
param([string]$Project = (Get-Location).Path)

$ErrorActionPreference = 'Stop'
$src = $PSScriptRoot
if (-not (Test-Path (Join-Path $Project '.git'))) { throw "Not a git repo: $Project" }

$fp = Join-Path $Project '.fishpond'
$cards = Join-Path $fp 'cards'
$docs = Join-Path $Project 'docs'
$docsHandoff = Join-Path $docs 'HANDOFF'
New-Item -ItemType Directory -Force -Path $fp, $cards, $docs, $docsHandoff | Out-Null

function Copy-IfMissing($srcFile, $destFile) {
  $leaf = Split-Path $destFile -Leaf
  if (-not (Test-Path $destFile)) {
    Copy-Item $srcFile $destFile -Force
    Write-Host ('[fishpond] + ' + $leaf) -ForegroundColor Green
  } else {
    Write-Host ('[fishpond] = ' + $leaf + ' (exists, skip)') -ForegroundColor DarkGray
  }
}

$tpl = Join-Path $src 'templates'
$fpMap = @{
  'PROJECT_PROFILE.md'='PROJECT_PROFILE.md'; 'ARCHITECTURE.md'='ARCHITECTURE.md'
  'FEATURE_LIST.md'='FEATURE_LIST.md'; 'UI_UX.md'='UI_UX.md'
  'DATA_MODEL.md'='DATA_MODEL.md'; 'API_SPEC.md'='API_SPEC.md'
  'ROADMAP.md'='ROADMAP.md'; 'TRACEABILITY.md'='TRACEABILITY.md'
  'NAVIGATION.md'='NAVIGATION.md'; 'HANDOFF.md'='HANDOFF.md'
  'DEVLOG.md'='DEVLOG.md'; 'LESSONS.md'='LESSONS.md'
  'CHANGELOG.project.md'='CHANGELOG.md'
  'STORY_MAP.md'='STORY_MAP.md'; 'SYSTEM_GRAPH.md'='SYSTEM_GRAPH.md'
  'FLOW_ARCHITECTURE.md'='FLOW_ARCHITECTURE.md'
  'TASTE_PROFILE.md'='TASTE_PROFILE.md'
  'DARWIN_SCORES.md'='DARWIN_SCORES.md'; 'EVOLUTION.md'='EVOLUTION.md'
  'GIT_PROFILE.md'='GIT_PROFILE.md'; 'SESSION_STATE.md'='SESSION_STATE.md'
}
foreach ($k in $fpMap.Keys) { Copy-IfMissing (Join-Path $tpl $k) (Join-Path $fp $fpMap[$k]) }

$docsTpl = Join-Path $tpl 'docs'
Copy-IfMissing (Join-Path $docsTpl 'SOLUTION.md') (Join-Path $docs 'SOLUTION.md')
Copy-IfMissing (Join-Path $docsTpl 'SOP.md') (Join-Path $docs 'SOP.md')
Copy-IfMissing (Join-Path $docsTpl 'ONBOARDING.md') (Join-Path $docs 'ONBOARDING.md')
Copy-IfMissing (Join-Path $docsTpl 'ENGINEERING_CHARTER.md') (Join-Path $docs 'ENGINEERING_CHARTER.md')
Copy-IfMissing (Join-Path $docsTpl 'HANDOFF\README.md') (Join-Path $docsHandoff 'README.md')

$verify = Join-Path $fp 'verify.ps1'
if (-not (Test-Path $verify)) {
  Copy-Item (Join-Path $src 'enforcement\verify.example.ps1') $verify -Force
  Write-Host '[fishpond] + verify.ps1 (fill in build/test commands)' -ForegroundColor Yellow
}
$hookDir = Join-Path $Project '.githooks'
New-Item -ItemType Directory -Force -Path $hookDir | Out-Null
Copy-Item (Join-Path $src 'enforcement\pre-commit') (Join-Path $hookDir 'pre-commit') -Force
git -C $Project config core.hooksPath .githooks
Write-Host '[fishpond] pre-commit hook installed' -ForegroundColor Green

& (Join-Path $src 'setup-git.ps1') -Project $Project

Write-Host ''
Write-Host 'FishPond v2 init done.' -ForegroundColor Cyan
Write-Host '  1) Edit .fishpond/verify.ps1 and run it'
Write-Host '  2) Tell AI: use FishPond on this project, read SESSION_STATE and SYSTEM_GRAPH first'
