---
name: aethelark-upscale
description: >-
  Upscale brand images to 300 DPI print-ready masters using the Aethelark
  upscale pipeline (Real-ESRGAN neural models or organic optical Lanczos4).
  Use when the user says "Aethelark-Upscale", "brand upscale", "upscale for
  print", "300 DPI upscale", "merch upscale", "DTG upscale", "upscale these
  images", "make print ready", or asks to prepare images for POD/DTG/Printify/
  Printful/Amazon Merch. Also use when the user mentions low DPI warnings,
  print quality issues, or wants to batch-upscale a folder of designs.
---

# Aethelark-Upscale Skill

## Quick Reference

The CLI tool `brand-upscale` is already installed at `~/.local/bin/merch-upscale`
with symlinks: `brand-upscale`, `dtg-upscale`, `merch-upscale`.

GPU backend: Real-ESRGAN ncnn-vulkan on NVIDIA RTX 2050 (4 GB VRAM).
Models directory: `~/.local/share/aethelark/realesrgan/models/`

## Default Behavior

**Always default to `--organic` mode** unless the user explicitly requests a
neural model. Organic mode preserves the authentic photographic softness of
AI-generated images without introducing GAN hallucinations (waves, wax, plastic).

## Usage Patterns

### Single Image

```bash
brand-upscale <path-to-image> --organic
```

### Batch (Entire Folder)

```bash
brand-upscale <path-to-folder> --organic
```

### With Merch Canvas (4500×5400 POD template)

```bash
brand-upscale <path> --organic --merch
```

### Neural Mode (only if user explicitly asks for "sharp", "crisp", "neural")

```bash
brand-upscale <path> -n nmkd          # Ultra-sharp (NMKD Superscale)
brand-upscale <path> -n ultrasharp    # High-def sharp
brand-upscale <path> -n nomos         # Natural photo
brand-upscale <path> -n anime         # Flat art / vector / logo
brand-upscale <path> -n esrgan        # Classic Real-ESRGAN
```

## Step-by-Step Execution

1. **Identify the target**: Resolve the path the user mentioned (file or folder).
2. **Choose the mode**:
   - Default → `--organic` (preserves natural look, zero AI artifacts)
   - User says "sharp" / "crisp" / "neural" / "NMKD" → use `-n <model>`
   - User says "anime" / "vector" / "logo" / "graphic" → use `-n anime`
3. **Add flags if mentioned**:
   - "merch" / "POD" / "shirt" / "canvas" → add `--merch`
   - Custom canvas → `--canvas WIDTHxHEIGHT`
   - Custom DPI → `--dpi <N>`
4. **Run the command** via shell.
5. **Report results**: Show the output path(s), final resolution, DPI, and
   print dimensions. If a folder was processed, list all processed files.

## Output Convention

- Single file: `<original_stem>_300dpi_master.png` in the same directory
- Folder: `<folder>/polished_300dpi_masters/` subdirectory

## What It Does (for context)

- 4× resolution upscale (organic optical OR neural super-resolution)
- Alpha halo purge (eliminates white DTG underbase ghost fringing)
- sRGB IEC61966-2.1 ICC profile embedding
- 300 DPI pHYs metadata stamping
- Optional 4500×5400 master merch canvas centering

## Troubleshooting

- If `brand-upscale` is not found: check `~/.local/bin` is in PATH
- If GPU fails: the binary needs `realesrgan-ncnn-vulkan` with Vulkan drivers
- If a model is missing: check `~/.local/share/aethelark/realesrgan/models/`

For full CLI reference, see [cli-reference.md](./references/cli-reference.md).
