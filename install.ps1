<#
FishPond 技能安装器 → 安装为 RingPond 圈域 (Windows / PowerShell)

把本技能装进 Claude Code / Cursor 的技能目录（目录名 ringpond）。
用法：
  ./install.ps1                    # Claude Code（默认）
  ./install.ps1 -Target cursor
  ./install.ps1 -Target both
  ./install.ps1 -Project C:\path\to\project
#>
param(
  [ValidateSet('claude','cursor','both')] [string]$Target = 'claude',
  [string]$Project = ''
)

$ErrorActionPreference = 'Stop'
$src = $PSScriptRoot
if (-not (Test-Path (Join-Path $src 'SKILL.md'))) { throw "在 $src 找不到 SKILL.md，请在技能根目录运行。" }

function Install-To($dir) {
  $dest = Join-Path $dir 'ringpond'
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
  # 排除 .git，避免把发布用 git 历史装进技能目录
  Get-ChildItem $src -Force | Where-Object { $_.Name -ne '.git' } | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $dest $_.Name) -Recurse -Force
  }
  Write-Host "[fishpond] 已安装 -> $dest" -ForegroundColor Green
}

$homeDir = $HOME
if ($Target -in 'claude','both') { Install-To (Join-Path $homeDir '.claude\skills') }
if ($Target -in 'cursor','both') { Install-To (Join-Path $homeDir '.cursor\skills') }

if ($Project -ne '') {
  if (-not (Test-Path (Join-Path $Project '.git'))) { throw "$Project 不是 git 仓库。" }
  $hookDir = Join-Path $Project '.githooks'
  New-Item -ItemType Directory -Force -Path $hookDir | Out-Null
  Copy-Item (Join-Path $src 'enforcement\pre-commit') (Join-Path $hookDir 'pre-commit') -Force
  git -C $Project config core.hooksPath .githooks
  Write-Host "[fishpond] 已在 $Project 安装 pre-commit 门禁（core.hooksPath=.githooks）。" -ForegroundColor Green

  $fp = Join-Path $Project '.fishpond'
  New-Item -ItemType Directory -Force -Path $fp | Out-Null
  $verify = Join-Path $fp 'verify.ps1'
  if (-not (Test-Path $verify)) {
    Copy-Item (Join-Path $src 'enforcement\verify.example.ps1') $verify -Force
    Write-Host "[fishpond] 已放入 .fishpond/verify.ps1 起始模板 —— 请填入真实的 构建/测试/覆盖率 命令。" -ForegroundColor Yellow
  }
  Write-Host "[fishpond] CI 门禁模板见 enforcement/ci.example.yml，复制到 .github/workflows/ci.yml 并设为必需检查。" -ForegroundColor Cyan
}

Write-Host "[ringpond] Done. Restart Claude Code/Cursor. Say: use RingPond on this project." -ForegroundColor Cyan
