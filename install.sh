#!/bin/sh
# FishPond 技能安装器 (macOS / Linux)
#
# 用法：
#   ./install.sh                 # 装进 Claude Code（默认，用户级 ~/.claude/skills）
#   ./install.sh cursor          # 装进 Cursor（~/.cursor/skills）
#   ./install.sh both            # 两个都装
#   ./install.sh claude /path/to/project   # 同时给某项目装 git pre-commit 门禁
set -e

TARGET="${1:-claude}"
PROJECT="${2:-}"
SRC="$(cd "$(dirname "$0")" && pwd)"
[ -f "$SRC/SKILL.md" ] || { echo "在 $SRC 找不到 SKILL.md"; exit 1; }

install_to() {
  DIR="$1"; DEST="$DIR/ringpond"
  mkdir -p "$DIR"; rm -rf "$DEST"; mkdir -p "$DEST"
  for item in "$SRC"/* "$SRC"/.[!.]*; do
    base="$(basename "$item")"
    [ "$base" = ".git" ] && continue
    [ -e "$item" ] || continue
    cp -R "$item" "$DEST/"
  done
  echo "[fishpond] 已安装 -> $DEST"
}

case "$TARGET" in
  claude|both) install_to "$HOME/.claude/skills" ;;
esac
case "$TARGET" in
  cursor|both) install_to "$HOME/.cursor/skills" ;;
esac

if [ -n "$PROJECT" ]; then
  [ -d "$PROJECT/.git" ] || { echo "$PROJECT 不是 git 仓库"; exit 1; }
  mkdir -p "$PROJECT/.githooks"
  cp "$SRC/enforcement/pre-commit" "$PROJECT/.githooks/pre-commit"
  chmod +x "$PROJECT/.githooks/pre-commit"
  git -C "$PROJECT" config core.hooksPath .githooks
  mkdir -p "$PROJECT/.fishpond"
  if [ ! -f "$PROJECT/.fishpond/verify.sh" ]; then
    cp "$SRC/enforcement/verify.example.sh" "$PROJECT/.fishpond/verify.sh"
    chmod +x "$PROJECT/.fishpond/verify.sh"
    echo "[fishpond] 已放入 .fishpond/verify.sh 起始模板 —— 请填入真实的 构建/测试/覆盖率 命令。"
  fi
  echo "[fishpond] 已在 $PROJECT 安装 pre-commit 门禁。CI 模板见 enforcement/ci.example.yml。"
fi
# 给发布包内脚本打可执行位（便于克隆后直接跑）
chmod +x "$SRC/install.sh" "$SRC/enforcement/pre-commit" "$SRC/enforcement/verify.example.sh" 2>/dev/null || true

echo "[fishpond] 完成。重启 Claude Code / Cursor 后，说'用 FishPond 开发…'即可触发。"
