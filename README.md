# 🦅 Aethelark-Upscale

> **The Agent-Native 300 DPI GPU Image Super-Resolution & Print Polish Engine.**  
> Free for personal use. Runs locally on NVIDIA GPUs via Vulkan.  
> Created by **Alexandru Cioponea (Aethelark)**.

[![License: Aethelark Source-Available](https://img.shields.io/badge/License-Aethelark%20v1.0-blue.svg)](LICENSE)
[![Platform: Linux x86_64](https://img.shields.io/badge/Platform-Linux%20x86__64-orange.svg)](#requirements)
[![GPU: NVIDIA Vulkan](https://img.shields.io/badge/GPU-Vulkan%20Accelerated-green.svg)](#features)
[![Print: 300 DPI DTG Ready](https://img.shields.io/badge/Print-300%20DPI%20DTG%20Ready-brightgreen.svg)](#preflight-engineering)
[![Agent: Claude & Gemini Native](https://img.shields.io/badge/AI%20Agent-Claude%20%7C%20Gemini%20Native-purple.svg)](#-for-ai-agents)

---

## ⚡ What is Aethelark-Upscale?

**Aethelark-Upscale** is a local GPU image upscaler built specifically for **autonomous AI agents** (Claude Code, Gemini CLI, Cursor, Copilot, OpenDevin) and **human creators**.

Most upscalers are either bloated GUI apps, locked behind paid API subscriptions, or produce synthetic "AI slop" (uncanny plastic textures, waxy skin, and squiggly GAN wave hallucinations on smooth surfaces).

Aethelark-Upscale solves this with a **dual-engine architecture**:
1. **🌱 Organic Optical Mode (`--organic`)**: Uses 4x high-order Lanczos-4 sinc interpolation to scale images to true 300 DPI print scale while **preserving 100% of the authentic photographic softness, depth-of-field, and camera glass aesthetics**—zero AI hallucinations, zero plastic wax, zero squiggly ripples.
2. **⚡ Neural Super-Resolution (`-n nmkd` / `ultrasharp` / `anime`)**: Direct Vulkan GPU hardware inference for razor-sharp mechanical edges, micro-trace clarity, and flat-art/vector reconstruction.

Both modes automatically run through the **Aethelark Print Preflight Pipeline**:
- **Alpha Halo Purge**: Clamps faint edge transparency ($0 < \alpha \le 4 \to 0$) and zeroes RGB values under transparent pixels. Eliminates the dreaded chalky white ink underbase ghost outline that ruins Direct-to-Garment (DTG) prints on black garments.
- **300.0 Physical DPI Stamping**: Writes explicit PNG `pHYs` chunks to pass Print-on-Demand (Printify, Printful, Amazon Merch) upload preflights with instant green checkmarks.
- **sRGB IEC61966-2.1 Color Profile**: Embeds universal ICC profiles to prevent murky CMYK color-shifting in industrial RIP print engines.
- **Universal Merch Template (`--merch`)**: Automatically centers artwork on the standard 4500×5400 master apparel canvas.

---

## 🚀 One-Line Installation

Run this single command in your terminal or agent shell:

```bash
curl -fsSL https://raw.githubusercontent.com/ciopialex/Aethelark-Upscale/main/install.sh | bash
```

The installer will:
1. Verify Linux x86_64 & Python 3.
2. Download the high-performance Real-ESRGAN Vulkan engine.
3. Fetch community neural weights (NMKD Superscale, UltraSharp, Siax, Nomos).
4. Install minimal Python dependencies (`pillow`, `numpy`, `opencv-python-headless`).
5. Drop `aethelark-upscale`, `brand-upscale`, and `merch-upscale` into `~/.local/bin/`.

---

## 🤖 For AI Agents

Aethelark-Upscale was engineered from day one for AI agents to call inside automated coding and design pipelines.

### Drop-in Agent Skill (Claude Code & Gemini CLI / Antigravity)

Clone the repo and copy the bundled `skill/` into your agent's directory:

```bash
# For Claude Code:
cp -r skill/ ~/.claude/skills/aethelark-upscale/

# For Gemini CLI / Antigravity:
cp -r skill/ ~/.gemini/config/skills/aethelark-upscale/
```

### Agent Natural Language Commands

Once installed, simply say to your agent:
- *"Apply the Aethelark-Upscale to all the images in that folder"*
- *"Aethelark-Upscale this image for print"*
- *"Upscale ~/designs/ to 300 DPI for Printify"*
- *"Batch upscale my brand assets using organic mode"*

The agent will read [`skill/SKILL.md`](skill/SKILL.md) and execute:

```bash
aethelark-upscale <path> --organic
```

All processed images will be saved with full 300 DPI print metadata in:
`<folder>/polished_300dpi_masters/`

---

## 💻 CLI Usage

### 1. Organic Upscale (Recommended for Generative AI & Photos)
Preserves authentic lens blur, photographic continuous tone, and eliminates AI wave hallucinations:

```bash
aethelark-upscale my-design.png --organic
```

### 2. Batch Process an Entire Directory
```bash
aethelark-upscale ~/my-brand-assets/ --organic
```

### 3. Print-on-Demand Apparel Master Canvas (4500×5400)
Centers the graphic onto the universal master print canvas used by Printify, Printful, and Amazon Merch:

```bash
aethelark-upscale logo.png --organic --merch
```

### 4. Neural Super-Resolution (For Mechanical, Tech & Vector Art)
When you need maximum crisp edge reconstruction:

```bash
# Ultra-sharp mechanical / technical art
aethelark-upscale circuit.png -n nmkd

# Balanced high-def realism
aethelark-upscale photo.png -n ultrasharp

# Flat graphic art, vector logos, and anime
aethelark-upscale emblem.png -n anime
```

---

## 🧠 Model Comparison Matrix

| Model Alias | Engine | Best For | Characteristics |
| :--- | :--- | :--- | :--- |
| `--organic` | Lanczos-4 Optical | AI Art, Photos, Apparel | **Zero AI artifacts**, preserves authentic optical lens softness, 300 DPI |
| `nmkd` | 4x_NMKD-Superscale | Hardware, Tech, Crisp Renders | Maximum edge contrast (+90% sharpness), structural line pop |
| `ultrasharp` | 4x-UltraSharp | Mixed Artwork, Merchandise | Balanced clarity, clean denoising, rich micro-contrast |
| `siax` | 4x_NMKD-Siax | Real Photography | Gentle skin tones, natural organic textures |
| `nomos` | 4xNomos8kSC | Film & Analog Visuals | Filmic continuous tone without synthetic edge snapping |
| `anime` | realesrgan-x4plus-anime | Logos, Vectors, Flat Graphics | Smooth flat colors, razor vector line clean-up |

---

## ⚙️ Full CLI Options

```
usage: aethelark-upscale [-h] [-o OUTPUT] [-n MODEL] [--organic]
                         [--style {photo,realistic,graphic,anime,vector,logo}]
                         [-s {2,3,4}] [--dpi DPI]
                         [--alpha-threshold ALPHA_THRESHOLD] [--raw]
                         [--sharpness SHARPNESS] [--specular SPECULAR]
                         [--merch] [--canvas CANVAS] [-v]
                         input

Positional Arguments:
  input                  Path to input image or directory

Optional Arguments:
  -o, --output           Output destination file or directory path
  -n, --model            Neural model: nmkd (default), ultrasharp, siax, nomos, esrgan, anime
  --organic, --natural   Use Optical Lanczos4 mode (preserves natural photographic softness)
  --style                Shorthand: 'graphic'/'vector'/'logo' -> anime; 'photo' -> nmkd
  -s, --scale            Upscaling factor: 2, 3, or 4 (default: 4)
  --dpi                  Target physical DPI stamp (default: 300)
  --alpha-threshold      Alpha cutoff (0-255) to purge white ghost underbase halos (default: 4)
  --raw                  Disable Clean Polish enhancement
  --sharpness            Edge clarity boost strength (default: 0.65)
  --specular             Specular highlight pop intensity (default: 12.0)
  --merch                Center onto 4500x5400 standard master apparel canvas
  --canvas WIDTHxHEIGHT  Custom master canvas dimensions (e.g. 4500x5400)
  -v, --verbose          Enable verbose debug logs
```

---

## 🛠️ Requirements

- **Operating System**: Linux x86_64 (Ubuntu 20.04+, Debian 11+, Fedora 36+, Arch Linux)
- **GPU**: NVIDIA, AMD, or Intel GPU with Vulkan driver support
- **Python**: 3.10 or newer (`pillow`, `numpy`, `opencv-python-headless`)

---

## 📜 License & Anti-Cloning Notice

This software is distributed under the **[Aethelark Source-Available License v1.0](LICENSE)**.

### Summary of Terms:
- **✅ Free for Personal Use**: Anyone may use, study, and run this tool for personal, non-commercial, or educational projects.
- **🚫 Mandatory Attribution**: Any fork, mirror, redistribution, or modification **MUST prominently credit Alexandru Cioponea (Aethelark)** and provide a direct link to this repository (`https://github.com/ciopialex/Aethelark-Upscale`). Cloning or re-uploading without mentioning Alexandru Cioponea is strictly prohibited.
- **🚫 Non-Commercial Only**: You may NOT sell, monetize, bundle in paid apps, or offer this software as a paid cloud SaaS without prior written authorization.

For commercial licensing, enterprise deployment, or bespoke agent integrations:  
📧 **Contact**: `shennyonthebeat@gmail.com`  
🌐 **GitHub**: [@ciopialex](https://github.com/ciopialex)
