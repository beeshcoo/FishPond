#!/bin/sh
# FishPond verify（POSIX sh 版）—— 项目"构建 && 测试(+覆盖率阈值)"的聚合命令。
# Phase 0 按 PROJECT_PROFILE.md 填实，拷到 <项目>/.fishpond/verify.sh。
# pre-commit 与 CI 都会调用它；任何一步非 0 退出即整体失败、阻断提交/合并。
set -e

echo "[verify] 1/2 构建 ..."
# <构建命令>  例：  mvn -q compile   |   go build ./...   |   pnpm build

echo "[verify] 2/2 测试（含覆盖率阈值，未达标应自身失败）..."
# <测试命令>  例：
#   mvn -q test                              # 用 jacoco check 设阈值
#   go test -cover ./...                     # 配合脚本判定阈值
#   pnpm test -- --coverage                  # vitest/jest 用 coverageThreshold
# 覆盖率阈值从 PROJECT_PROFILE.md「覆盖率阈值」取；未达标必须让本脚本非 0 退出。

echo "[verify] OK（全绿）"
