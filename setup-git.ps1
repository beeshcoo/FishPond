<#
FishPond Git 画像初始化 —— 记录仓库与 git 用户信息（不含 token）。
用法：./setup-git.ps1 [-Project 路径]
#>
param([string]$Project = (Get-Location).Path)

$ErrorActionPreference = 'Stop'
$fp = Join-Path $Project '.fishpond'
if (-not (Test-Path $fp)) { throw "请先运行 init-project.ps1 生成 .fishpond/" }

$remote = ''
try { $remote = (git -C $Project remote get-url origin 2>$null) } catch {}
$branch = ''
try { $branch = (git -C $Project symbolic-ref --short HEAD 2>$null) } catch { $branch = 'main' }
$gname = git -C $Project config user.name 2>$null
$gemail = git -C $Project config user.email 2>$null

$dest = Join-Path $fp 'GIT_PROFILE.md'
$tpl = Join-Path $PSScriptRoot 'templates\GIT_PROFILE.md'
if (-not (Test-Path $dest)) { Copy-Item $tpl $dest -Force }

$content = Get-Content $dest -Raw -Encoding UTF8
$content = $content -replace '远程仓库: "<[^"]*>"', "远程仓库: `"$remote`""
$content = $content -replace '默认分支: "[^"]*"', "默认分支: `"$branch`""
$content = $content -replace 'Git 用户: "<[^"]*>"', "Git 用户: `"$gname`""
$content = $content -replace 'Git 邮箱: "<[^"]*>"', "Git 邮箱: `"$gemail`""
[System.IO.File]::WriteAllText($dest, $content, [Text.UTF8Encoding]::new($false))

Write-Host "[fishpond] GIT_PROFILE.md 已更新（未记录任何 token）" -ForegroundColor Green
Write-Host "  remote: $remote"
Write-Host "  branch: $branch"
Write-Host "  user:   $gname <$gemail>"
