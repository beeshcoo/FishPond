<#
FishPond Git profile setup - records repo info (no tokens).
Usage: ./setup-git.ps1 [-Project path]
#>
param([string]$Project = (Get-Location).Path)

$ErrorActionPreference = 'Stop'
$fp = Join-Path $Project '.fishpond'
if (-not (Test-Path $fp)) { throw "Run init-project.ps1 first to create .fishpond/" }

$remote = ''
try { $remote = (git -C $Project remote get-url origin 2>$null) } catch {}
$branch = 'main'
try { $b = git -C $Project symbolic-ref --short HEAD 2>$null; if ($b) { $branch = $b } } catch {}
$gname = git -C $Project config user.name 2>$null
$gemail = git -C $Project config user.email 2>$null

$dest = Join-Path $fp 'GIT_PROFILE.md'
$tpl = Join-Path $PSScriptRoot 'templates\GIT_PROFILE.md'
if (-not (Test-Path $dest)) { Copy-Item $tpl $dest -Force }

$content = [System.IO.File]::ReadAllText($dest, [Text.Encoding]::UTF8)
$content = $content -replace '远程仓库: "<[^"]*>"', ('远程仓库: "' + $remote + '"')
$content = $content -replace '默认分支: "[^"]*"', ('默认分支: "' + $branch + '"')
$content = $content -replace 'Git 用户: "<[^"]*>"', ('Git 用户: "' + $gname + '"')
$content = $content -replace 'Git 邮箱: "<[^"]*>"', ('Git 邮箱: "' + $gemail + '"')
[System.IO.File]::WriteAllText($dest, $content, [Text.UTF8Encoding]::new($false))

Write-Host '[fishpond] GIT_PROFILE.md updated (no token stored)' -ForegroundColor Green
Write-Host ('  remote: ' + $remote)
Write-Host ('  branch: ' + $branch)
Write-Host ('  user:   ' + $gname + ' / ' + $gemail)
