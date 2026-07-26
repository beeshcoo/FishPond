#!/bin/sh
# FishPond 项目初始化器 —— 在目标项目里生成完整 .fishpond/ 骨架 + 安装 git 门禁。
# 用法：./init-project.sh [项目路径]   （默认当前目录）
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
PROJECT="${1:-$(pwd)}"
[ -d "$PROJECT/.git" ] || { echo "$PROJECT 不是 git 仓库"; exit 1; }

FP="$PROJECT/.fishpond"
mkdir -p "$FP/cards"

copy_if_missing() {
  src="$1"; dest="$2"
  if [ ! -f "$dest" ]; then
    cp "$src" "$dest"
    echo "[fishpond] + $(basename "$dest")"
  else
    echo "[fishpond] = $(basename "$dest") (已存在，跳过)"
  fi
}

T="$SRC/templates"
copy_if_missing "$T/PROJECT_PROFILE.md" "$FP/PROJECT_PROFILE.md"
copy_if_missing "$T/ARCHITECTURE.md"      "$FP/ARCHITECTURE.md"
copy_if_missing "$T/FEATURE_LIST.md"      "$FP/FEATURE_LIST.md"
copy_if_missing "$T/UI_UX.md"             "$FP/UI_UX.md"
copy_if_missing "$T/DATA_MODEL.md"        "$FP/DATA_MODEL.md"
copy_if_missing "$T/API_SPEC.md"          "$FP/API_SPEC.md"
copy_if_missing "$T/ROADMAP.md"           "$FP/ROADMAP.md"
copy_if_missing "$T/TRACEABILITY.md"      "$FP/TRACEABILITY.md"
copy_if_missing "$T/NAVIGATION.md"        "$FP/NAVIGATION.md"
copy_if_missing "$T/HANDOFF.md"           "$FP/HANDOFF.md"
copy_if_missing "$T/DEVLOG.md"            "$FP/DEVLOG.md"
copy_if_missing "$T/LESSONS.md"           "$FP/LESSONS.md"
copy_if_missing "$T/CHANGELOG.project.md" "$FP/CHANGELOG.md"

if [ ! -f "$FP/verify.sh" ]; then
  cp "$SRC/enforcement/verify.example.sh" "$FP/verify.sh"
  chmod +x "$FP/verify.sh"
  echo "[fishpond] + verify.sh（请填入真实构建/测试命令）"
fi

mkdir -p "$PROJECT/.githooks"
cp "$SRC/enforcement/pre-commit" "$PROJECT/.githooks/pre-commit"
chmod +x "$PROJECT/.githooks/pre-commit"
git -C "$PROJECT" config core.hooksPath .githooks
echo "[fishpond] pre-commit 门禁已安装"

echo ""
echo "完成。下一步："
echo "  1) 编辑 $FP/verify.sh —— 填入真实构建+测试命令并真跑一次"
echo "  2) 对 AI 说：用 FishPond 接手/开发这个项目，先读 .fishpond/ 再继续"
echo "  3) CI：复制 enforcement/ci.example.yml → .github/workflows/ci.yml"
