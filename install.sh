#!/bin/bash
# Shay-Rolls Guard — One-Line Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/giggso/shay-rolls-claude-guard/main/install.sh | bash
# Requires: Shay-Rolls Core installed first

set -e
G='\033[0;32m' Y='\033[1;33m' R='\033[0;31m' B='\033[0;34m' W='\033[1m' N='\033[0m'

REPO="https://github.com/giggso/shay-rolls-claude-guard.git"
INSTALL_DIR="$HOME/.shay-rolls-claude-guard"
BIN_DIR="$HOME/.local/bin"

echo ""
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${W}  Shay-Rolls Guard — Installer${N}"
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""

# Check Core is installed
command -v shay-rolls-init &>/dev/null || [ -f "$HOME/.shay-rolls-claude/shay-rolls-init.sh" ] || {
    echo -e "${R}❌ Shay-Rolls Core not installed.${N}"
    echo -e "   Run first: ${B}curl -fsSL https://raw.githubusercontent.com/giggso/shay-rolls-claude/main/install.sh | bash${N}"
    exit 1
}

# Download or update
if [ -d "$INSTALL_DIR/.git" ]; then
    echo -e "${B}Updating Guard...${N}"
    cd "$INSTALL_DIR" && git pull --quiet
    echo -e "${G}✅ Updated${N}"
else
    echo -e "${B}Downloading Shay-Rolls Guard...${N}"
    git clone --quiet --depth=1 "$REPO" "$INSTALL_DIR"
    echo -e "${G}✅ Downloaded to $INSTALL_DIR${N}"
fi

mkdir -p "$BIN_DIR"
cat > "$BIN_DIR/shay-rolls-guard-init" << CMDEOF
#!/bin/bash
bash "$INSTALL_DIR/shay-rolls-guard-setup.sh" "\$@"
CMDEOF
chmod +x "$BIN_DIR/shay-rolls-guard-init"

echo ""
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${G}  ✅ Guard installed${N}"
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
echo -e "  To add Guard to any project (after Core init):"
echo -e "  ${B}cd YourProject && shay-rolls-guard-init${N}"
echo ""
