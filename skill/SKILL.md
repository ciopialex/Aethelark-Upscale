---
name: aethelark-upscale
description: >-
  Upscale brand images to 300 DPI print-ready masters using the Aethelark
  upscale pipeline (Organic optical Lanczos4 by default, or Real-ESRGAN neural models).
  Use when the user says "Aethelark-Upscale", "brand upscale", "upscale for
  print", "300 DPI upscale", "merch upscale", "DTG upscale", "upscale these
  images", "make print ready", "upscale before webp", or asks to prepare images
  for POD/DTG/Printify/Printful/Amazon Merch/Websites. Also use when preparing
  AI-generated assets for websites or merchandise.
---

# Aethelark-Upscale Skill

## Quick Reference

The CLI tool `aethelark-upscale` is installed at `~/.local/bin/aethelark-upscale`
with symlinks: `brand-upscale`, `dtg-upscale`, `merch-upscale`.

Engine:
- **Default Mode**: Organic Optical (Lanczos4). 100% authentic photographic softness, zero AI wave/plastic artifacts, 300 DPI physical print compliance.
- **Neural Mode**: Hardware-accelerated Vulkan super-resolution (NMKD, UltraSharp, Anime) via `-n <model>` or `--neural`.

## Default Behavior

**`aethelark-upscale` defaults to ORGANIC mode automatically without any flags.**
It smoothly scales images 4×, purges white ink ghost alpha halos, stamps 300 DPI metadata, and embeds the sRGB IEC61966-2.1 ICC profile.

## Common Agent Usage Patterns

### 1. Single Image (Default Organic)
```bash
aethelark-upscale <path-to-image>
```

### 2. Batch Process an Entire Folder
```bash
aethelark-upscale <path-to-folder>
```

### 3. Website Asset Pipeline (Upscale -> WebP)
When the user asks to upscale images before turning them into webp for websites:
```bash
# Step 1: Upscale folder (produces polished 4x masters with clean alpha & continuous tone)
aethelark-upscale ./raw_assets/

# Step 2: Convert masters to lightweight WebP (e.g. via Python or cwebp)
python3 -c "
from PIL import Image
from pathlib import Path
for p in Path('./raw_assets/polished_300dpi_masters').glob('*.png'):
    img = Image.open(p)
    out_webp = p.parent.parent / f'{p.stem.replace(\"_300dpi_master\", \"\")}.webp'
    img.save(out_webp, 'WEBP', quality=85, method=6)
    print(f'Saved webp: {out_webp}')
"
```

### 4. Print-on-Demand Apparel Master (4500×5400 Canvas)
```bash
aethelark-upscale <path> --merch
```

### 5. Neural Mode (Only when user explicitly asks for "sharp", "crisp", "neural", or "anime")
```bash
aethelark-upscale <path> -n nmkd          # Ultra-sharp mechanical / tech art
aethelark-upscale <path> -n ultrasharp    # High-def sharp realism
aethelark-upscale <path> -n anime         # Flat art / vector / logo
aethelark-upscale <path> -n nomos         # Filmic photo texture
```

## Step-by-Step Execution for Agents

1. **Identify the target**: Resolve the path the user mentioned (file or folder).
2. **Determine mode**:
   - Default → Naked call (`aethelark-upscale <path>`). This runs Organic mode automatically.
   - User explicitly requests "neural", "sharp", or "NMKD" → Pass `-n nmkd` or `--neural`.
   - User requests "logo", "vector", or "anime" → Pass `-n anime`.
3. **Check for merch/canvas requirements**:
   - T-shirt / POD canvas needed → Add `--merch`.
4. **Execute command via shell**.
5. **Report results**: Output path(s), final resolution, DPI, and print/web readiness.

## Output Convention

- Single file: `<original_stem>_300dpi_master.png` in the same directory.
- Folder: `<folder>/polished_300dpi_masters/` subdirectory.
