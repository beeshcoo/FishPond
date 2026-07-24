# FishPond verify（PowerShell 版）—— 项目"构建 && 测试(+覆盖率阈值)"的聚合命令。
# 适用于 Windows / 命令为 PowerShell 的项目。Phase 0 按 PROJECT_PROFILE.md 填实，
# 拷到 <项目>/.fishpond/verify.ps1。pre-commit 检测到它就优先运行它。
$ErrorActionPreference = 'Stop'

function Invoke-Step($name, $cmd) {
  Write-Host "[verify] $name ..."
  & ([scriptblock]::Create($cmd))
  if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0) {
    Write-Host "[verify] 失败：$name（退出码 $LASTEXITCODE）" -ForegroundColor Red
    exit $LASTEXITCODE
  }
}

# <构建命令>  例： 'mvn -q compile'  |  'pnpm build'
Invoke-Step "1/2 构建" 'echo TODO-替换为构建命令'

# <测试命令>  例： 'mvn -q test'  |  'pnpm test -- --coverage'
# 覆盖率阈值从 PROJECT_PROFILE.md「覆盖率阈值」取；未达标必须让测试命令自身非 0 退出。
Invoke-Step "2/2 测试(含覆盖率阈值)" 'echo TODO-替换为测试命令'

Write-Host "[verify] OK（全绿）" -ForegroundColor Green
exit 0
