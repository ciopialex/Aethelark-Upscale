#!/usr/bin/env bash
# ==============================================================================
# Aethelark-Upscale Automated Installer
# GPU-Accelerated Image Super-Resolution & 300 DPI Print Engine
# Created by Alexandru Cioponea (Aethelark)
# https://github.com/ciopialex/Aethelark-Upscale
# ==============================================================================

set -euo pipefail

BOLD="\033[1m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
RESET="\033[0m"

echo -e "${BOLD}${BLUE}"
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                  Aethelark-Upscale Installer                     ║"
echo "║         GPU Image Super-Resolution & 300 DPI Print Engine        ║"
echo "║                   Designed for AI Agents & Humans                ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${RESET}"

# 1. System checks
echo -e "${BOLD}▶ Checking system prerequisites...${RESET}"
OS="$(uname -s)"
ARCH="$(uname -m)"

if [[ "$OS" != "Linux" ]] || [[ "$ARCH" != "x86_64" ]]; then
    echo -e "${RED}❌ Error: Aethelark-Upscale currently requires Linux x86_64.${RESET}"
    exit 1
fi

if ! command -v python3 &>/dev/null; then
    echo -e "${RED}❌ Error: Python 3 is required. Please install python3.${RESET}"
    exit 1
fi

if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
    echo -e "${RED}❌ Error: curl or wget is required for downloading dependencies.${RESET}"
    exit 1
fi

# Download helper
fetch() {
    local url="$1"
    local dest="$2"
    if command -v curl &>/dev/null; then
        curl -fsSL "$url" -o "$dest"
    else
        wget -q -O "$dest" "$url"
    fi
}

INSTALL_DIR="${AETHELARK_ESRGAN_DIR:-$HOME/.local/share/aethelark/realesrgan}"
MODELS_DIR="$INSTALL_DIR/models"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$INSTALL_DIR" "$MODELS_DIR" "$BIN_DIR"

# 2. Download Real-ESRGAN Vulkan engine if missing
ESRGAN_BIN="$INSTALL_DIR/realesrgan-ncnn-vulkan"
if [[ ! -f "$ESRGAN_BIN" ]]; then
    echo -e "${YELLOW}⚡ Downloading Real-ESRGAN Vulkan engine (MIT)...${RESET}"
    TMP_ZIP="/tmp/realesrgan-vulkan.zip"
    fetch "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesrgan-ncnn-vulkan-20220424-ubuntu.zip" "$TMP_ZIP"
    
    python3 -c "import zipfile; zipfile.ZipFile('$TMP_ZIP').extractall('$INSTALL_DIR')"
    rm -f "$TMP_ZIP"
    chmod +x "$ESRGAN_BIN"
    echo -e "${GREEN}✓ Real-ESRGAN engine installed successfully.${RESET}"
else
    echo -e "${GREEN}✓ Real-ESRGAN engine already present.${RESET}"
fi

# 3. Download community neural models
download_model() {
    local name="$1"
    local base_url="$2"
    local bin_file="$MODELS_DIR/$name.bin"
    local param_file="$MODELS_DIR/$name.param"

    if [[ ! -f "$bin_file" ]] || [[ ! -f "$param_file" ]]; then
        echo -e "  ↳ Downloading neural model: ${BOLD}$name${RESET}..."
        fetch "${base_url}.bin" "$bin_file"
        fetch "${base_url}.param" "$param_file"
    else
        echo -e "  ↳ Model ${BOLD}$name${RESET} is ready."
    fi
}

echo -e "\n${BOLD}▶ Checking neural models in ${MODELS_DIR}...${RESET}"

# NMKD Superscale
download_model "4x_NMKD-Superscale-SP_178000_G" \
    "https://raw.githubusercontent.com/upscayl/custom-models/main/models/4x_NMKD-Superscale-SP_178000_G"

# NMKD Siax
download_model "4x_NMKD-Siax_200k" \
    "https://raw.githubusercontent.com/upscayl/custom-models/main/models/4x_NMKD-Siax_200k"

# Nomos
download_model "4xNomos8kSC" \
    "https://raw.githubusercontent.com/upscayl/custom-models/main/models/4xNomos8kSC"

# UltraSharp
if [[ ! -f "$MODELS_DIR/4x-UltraSharp.bin" ]] || [[ ! -f "$MODELS_DIR/4x-UltraSharp.param" ]]; then
    echo -e "  ↳ Downloading neural model: ${BOLD}4x-UltraSharp${RESET}..."
    fetch "https://huggingface.co/Kim2091/UltraSharp/resolve/main/NCNN/4x-UltraSharp-fp16.bin" "$MODELS_DIR/4x-UltraSharp.bin"
    fetch "https://huggingface.co/Kim2091/UltraSharp/resolve/main/NCNN/4x-UltraSharp-fp16.param" "$MODELS_DIR/4x-UltraSharp.param"
else
    echo -e "  ↳ Model ${BOLD}4x-UltraSharp${RESET} is ready."
fi

# 4. Install Python dependencies
echo -e "\n${BOLD}▶ Verifying Python dependencies (pillow, numpy, opencv-python-headless)...${RESET}"
python3 -c "import cv2, numpy, PIL" 2>/dev/null || {
    echo -e "${YELLOW}Installing missing Python packages via pip...${RESET}"
    pip3 install --quiet --upgrade pillow numpy opencv-python-headless || \
    pip install --quiet --upgrade pillow numpy opencv-python-headless || {
        echo -e "${RED}⚠️ Could not run pip automatically. Please run:${RESET}"
        echo "   pip install pillow numpy opencv-python-headless"
    }
}

# 5. Install CLI tool & symlinks
echo -e "\n${BOLD}▶ Installing executable into ${BIN_DIR}...${RESET}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_EXE="$BIN_DIR/aethelark-upscale"

if [[ -f "$SCRIPT_DIR/aethelark-upscale" ]]; then
    cp "$SCRIPT_DIR/aethelark-upscale" "$TARGET_EXE"
else
    # Remote install fallback via curl
    fetch "https://raw.githubusercontent.com/ciopialex/Aethelark-Upscale/main/aethelark-upscale" "$TARGET_EXE"
fi

chmod +x "$TARGET_EXE"

ln -sf "$TARGET_EXE" "$BIN_DIR/brand-upscale"
ln -sf "$TARGET_EXE" "$BIN_DIR/merch-upscale"
ln -sf "$TARGET_EXE" "$BIN_DIR/dtg-upscale"

# 6. Check PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo -e "\n${YELLOW}⚠️ Notice: $BIN_DIR is not currently in your PATH.${RESET}"
    echo -e "Add this to your ~/.bashrc or ~/.zshrc:"
    echo -e "   export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo -e "\n${GREEN}${BOLD}══════════════════════════════════════════════════════════════════${RESET}"
echo -e "${GREEN}${BOLD}🎉 Aethelark-Upscale installed successfully!${RESET}"
echo -e "${GREEN}${BOLD}══════════════════════════════════════════════════════════════════${RESET}"
echo -e "Commands available:"
echo -e "  • ${BOLD}aethelark-upscale${RESET} (canonical)"
echo -e "  • ${BOLD}brand-upscale${RESET}"
echo -e "  • ${BOLD}merch-upscale${RESET}"
echo ""
echo -e "Quick test:"
echo -e "  aethelark-upscale --help"
echo -e "  aethelark-upscale my-image.png --organic"
echo ""
echo -e "Agent skill installation (Claude / Gemini):"
echo -e "  cp -r skill/ ~/.claude/skills/aethelark-upscale/"
echo -e "  cp -r skill/ ~/.gemini/config/skills/aethelark-upscale/"
echo ""
