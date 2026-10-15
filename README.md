# 🦅 Aethelark-Upscale

> **The Agent-Native 300 DPI GPU Image Super-Resolution & Print Polish Engine.**  
> Free for personal use. Runs locally on Linux, macOS, and Windows via GPU acceleration.  
> Created by **Alexandru Cioponea (Aethelark)**.

[![License: Aethelark Source-Available](https://img.shields.io/badge/License-Aethelark%20v1.0-blue.svg)](LICENSE)
[![Platform: Linux · macOS · Windows](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-orange.svg)](#-cross-platform-support)
[![GPU: Hardware Accelerated](https://img.shields.io/badge/GPU-Vulkan%20Accelerated-green.svg)](#-what-is-aethelark-upscale)
[![Print: 300 DPI DTG Ready](https://img.shields.io/badge/Print-300%20DPI%20DTG%20Ready-brightgreen.svg)](#-step-3-upload-to-your-store)
[![Agent: Claude & Gemini Native](https://img.shields.io/badge/AI%20Agent-Claude%20%7C%20Gemini%20Native-purple.svg)](#-for-ai-agents)

---

## 🪄 Quick Start for Non-Technical Users (60 Seconds)

> **Got a "Low Resolution / under 250 DPI" warning on Printify, Printful, or Amazon Merch?**  
> Want your Midjourney, ChatGPT, or digital art to print razor-sharp without looking like cheap plastic or getting weird wavy distortion?  
> Follow these 3 easy steps—**no coding experience needed**.

---

### Step 1: Install (Copy & Paste ONE line)

Open your **Terminal** (Mac/Linux) or **PowerShell** (Windows) and paste this:

**🍎 Mac & 🐧 Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/ciopialex/Aethelark-Upscale/main/install.sh | bash
```

**🪟 Windows (Press Start, type `PowerShell`, and paste):**
```powershell
irm https://raw.githubusercontent.com/ciopialex/Aethelark-Upscale/main/install.ps1 | iex
```

*(Press Enter and wait ~15 seconds while it sets up everything automatically).*

---

### Step 2: Upscale Your Image

Type `aethelark-upscale --organic ` and **drag & drop your image file into the terminal window**:

```bash
aethelark-upscale --organic [drag-and-drop-your-image-here]
```

> 💡 **Drag & Drop Trick**: You do NOT need to type long file paths! Just drag your image directly from your folder or desktop and drop it right into the terminal window—it will type the path for you automatically.

Want to upscale a **whole folder of images at once**? Just drag the whole folder:
```bash
aethelark-upscale --organic [drag-and-drop-folder-here]
```

---

### Step 3: Upload to Your Store!

Your finished master will be saved right next to your original file, named `[your-file]_300dpi_master.png`:

- **4× Bigger Resolution**: A 1000px image instantly becomes a 4000px ultra-high-res master.
- **100% Green Checkmarks**: Embedded with physical 300 DPI metadata so Printify, Printful, and Amazon Merch accept it immediately.
- **No Ugly White Outlines**: Automatically purges transparent ghost pixels so black t-shirts and hoodies don't print with a weird chalky halo around your art.
- **Natural Photographic Look (`--organic`)**: Keeps the natural lens blur and smooth shading of your original design without turning it into artificial, waxy "AI plastic".

---

## ⚡ What is Aethelark-Upscale?

**Aethelark-Upscale** is a high-performance, local image upscaler built specifically for **autonomous AI agents** (Claude Code, Gemini CLI, Cursor, Copilot, OpenDevin) and **human creators**.

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

## 💻 Cross-Platform Support

| Platform | Architecture | Acceleration Backend |
| :--- | :--- | :--- |
| **Linux** | x86_64 | NVIDIA, AMD, or Intel GPU via native Vulkan |
| **macOS** | Apple Silicon (M1/M2/M3/M4) & Intel | Apple Metal via MoltenVK & Vulkan runtime |
| **Windows** | Windows 10 & 11 (x64) | NVIDIA, AMD, or Intel GPU via DirectX 12 / Vulkan |

---

## 🤖 For AI Agents

Aethelark-Upscale was engineered from day one for AI agents to call inside automated coding and design pipelines across any operating system.

### Drop-in Agent Skill (Claude Code & Gemini CLI / Antigravity)

Clone the repo and copy the bundled `skill/` into your agent's directory:

```bash
# For Claude Code (Linux / macOS / WSL):
cp -r skill/ ~/.claude/skills/aethelark-upscale/

# For Gemini CLI / Antigravity (Linux / macOS / WSL):
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

## 💻 Power User CLI Options

### Print-on-Demand Apparel Master Canvas (4500×5400)
Centers the graphic onto the universal master print canvas used by Printify, Printful, and Amazon Merch:

```bash
aethelark-upscale logo.png --organic --merch
```

### Neural Super-Resolution (For Mechanical, Tech & Vector Art)
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

## ⚙️ Full CLI Options Reference

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

## 📜 License & Anti-Cloning Notice

This software is distributed under the **[Aethelark Source-Available License v1.0](LICENSE)**.

### Summary of Terms:
- **✅ Free for Personal Use**: Anyone may use, study, and run this tool for personal, non-commercial, or educational projects across Linux, macOS, and Windows.
- **🚫 Mandatory Attribution**: Any fork, mirror, redistribution, or modification **MUST prominently credit Alexandru Cioponea (Aethelark)** and provide a direct link to this repository (`https://github.com/ciopialex/Aethelark-Upscale`). Cloning or re-uploading without mentioning Alexandru Cioponea is strictly prohibited.
- **🚫 Non-Commercial Only**: You may NOT sell, monetize, bundle in paid apps, or offer this software as a paid cloud SaaS without prior written authorization.

For commercial licensing, enterprise deployment, or bespoke agent integrations:  
📧 **Contact**: `shennyonthebeat@gmail.com`  
🌐 **GitHub**: [@ciopialex](https://github.com/ciopialex)
