<#
FishPond 项目初始化器 —— 在目标项目里生成完整 .fishpond/ 骨架 + 安装 git 门禁。
用法：
  ./init-project.ps1                          # 当前目录
  ./init-project.ps1 -Project C:\path\to\proj  # 指定项目
#>
param(
  [string]$Project = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'
$src = $PSScriptRoot
if (-not (Test-Path (Join-Path $Project '.git'))) { throw "$Project 不是 git 仓库。请先 git init 或在项目根目录运行。" }

$fp = Join-Path $Project '.fishpond'
$cards = Join-Path $fp 'cards'
New-Item -ItemType Directory -Force -Path $fp, $cards | Out-Null

# 拷贝模板（不覆盖已有文件）
$tpl = Join-Path $src 'templates'
$map = @{
  'PROJECT_PROFILE.md' = 'PROJECT_PROFILE.md'
  'ARCHITECTURE.md'      = 'ARCHITECTURE.md'
  'FEATURE_LIST.md'      = 'FEATURE_LIST.md'
  'UI_UX.md'             = 'UI_UX.md'
  'DATA_MODEL.md'        = 'DATA_MODEL.md'
  'API_SPEC.md'          = 'API_SPEC.md'
  'ROADMAP.md'           = 'ROADMAP.md'
  'TRACEABILITY.md'      = 'TRACEABILITY.md'
  'NAVIGATION.md'        = 'NAVIGATION.md'
  'HANDOFF.md'           = 'HANDOFF.md'
  'DEVLOG.md'            = 'DEVLOG.md'
  'LESSONS.md'           = 'LESSONS.md'
  'CHANGELOG.project.md' = 'CHANGELOG.md'
}
foreach ($k in $map.Keys) {
  $dest = Join-Path $fp $map[$k]
  if (-not (Test-Path $dest)) {
    Copy-Item (Join-Path $tpl $k) $dest -Force
    Write-Host "[fishpond] + $($map[$k])" -ForegroundColor Green
  } else {
    Write-Host "[fishpond] = $($map[$k]) (已存在，跳过)" -ForegroundColor DarkGray
  }
}

# verify + pre-commit
$verify = Join-Path $fp 'verify.ps1'
if (-not (Test-Path $verify)) {
  Copy-Item (Join-Path $src 'enforcement\verify.example.ps1') $verify -Force
  Write-Host "[fishpond] + verify.ps1（请填入真实构建/测试命令）" -ForegroundColor Yellow
}
$hookDir = Join-Path $Project '.githooks'
New-Item -ItemType Directory -Force -Path $hookDir | Out-Null
Copy-Item (Join-Path $src 'enforcement\pre-commit') (Join-Path $hookDir 'pre-commit') -Force
git -C $Project config core.hooksPath .githooks
Write-Host "[fishpond] pre-commit 门禁已安装（core.hooksPath=.githooks）" -ForegroundColor Green

Write-Host ""
Write-Host "完成。下一步：" -ForegroundColor Cyan
Write-Host "  1) 编辑 $fp\verify.ps1 —— 填入真实构建+测试命令并真跑一次"
Write-Host "  2) 对 AI 说：用 FishPond 接手/开发这个项目，先读 .fishpond/ 再继续"
Write-Host "  3) CI：复制 enforcement/ci.example.yml → .github/workflows/ci.yml"
