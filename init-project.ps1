<#
FishPond 项目初始化器 v2 —— .fishpond/ + docs/ 全套 + 门禁 + Git 画像
用法：
  ./init-project.ps1
  ./init-project.ps1 -Project C:\path\to\proj
#>
param([string]$Project = (Get-Location).Path)

$ErrorActionPreference = 'Stop'
$src = $PSScriptRoot
if (-not (Test-Path (Join-Path $Project '.git'))) { throw "$Project 不是 git 仓库。" }

$fp = Join-Path $Project '.fishpond'
$cards = Join-Path $fp 'cards'
$docs = Join-Path $Project 'docs'
$docsHandoff = Join-Path $docs 'HANDOFF'
New-Item -ItemType Directory -Force -Path $fp, $cards, $docs, $docsHandoff | Out-Null

function Copy-IfMissing($srcFile, $destFile) {
  if (-not (Test-Path $destFile)) {
    Copy-Item $srcFile $destFile -Force
    Write-Host "[fishpond] + $(Split-Path $destFile -Leaf)" -ForegroundColor Green
  } else {
    Write-Host "[fishpond] = $(Split-Path $destFile -Leaf) (已存在，跳过)" -ForegroundColor DarkGray
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
  Write-Host "[fishpond] + verify.ps1（请填入真实构建/测试命令）" -ForegroundColor Yellow
}
$hookDir = Join-Path $Project '.githooks'
New-Item -ItemType Directory -Force -Path $hookDir | Out-Null
Copy-Item (Join-Path $src 'enforcement\pre-commit') (Join-Path $hookDir 'pre-commit') -Force
git -C $Project config core.hooksPath .githooks
Write-Host "[fishpond] pre-commit 门禁已安装" -ForegroundColor Green

& (Join-Path $src 'setup-git.ps1') -Project $Project

Write-Host ""
Write-Host "FishPond v2 初始化完成。" -ForegroundColor Cyan
Write-Host "  1) 编辑 $fp\verify.ps1 并真跑"
Write-Host "  2) 对 AI：用 FishPond 接手这个项目，先读 SESSION_STATE 和 SYSTEM_GRAPH"
Write-Host "  3) 棕地：用 FishPond 只圈鱼塘测绘，不改代码"
