# brand-upscale CLI Reference

## Synopsis

```
brand-upscale <input> [options]
```

## Arguments

| Argument | Description |
|:---------|:------------|
| `input` | Path to image file or directory of images |

## Options

| Flag | Default | Description |
|:-----|:--------|:------------|
| `-o, --output` | auto | Output file or directory path |
| `-n, --model` | `nmkd` | Neural model: nmkd, ultrasharp, siax, nomos, esrgan, anime |
| `--organic / --natural` | off | Optical Lanczos4 mode (zero AI artifacts) |
| `--style` | — | Shorthand: photo/realistic → nmkd, graphic/anime/vector/logo → anime |
| `-s, --scale` | 4 | Upscaling factor (2, 3, or 4) |
| `--dpi` | 300 | Target physical DPI |
| `--alpha-threshold` | 4 | Alpha cutoff for ghost halo purge (0-255) |
| `--raw` | off | Disable Clean Polish post-processing |
| `--sharpness` | 0.65 | Edge clarity strength |
| `--specular` | 12.0 | Specular highlight pop intensity |
| `--merch` | off | Center onto 4500×5400 POD master canvas |
| `--canvas` | — | Custom canvas: WIDTHxHEIGHT (e.g. 4500x5400) |
| `-v, --verbose` | off | Verbose logging |

## Installed Models

| Alias | Full Model Name | Best For |
|:------|:----------------|:---------|
| `nmkd` | 4x_NMKD-Superscale-SP_178000_G | Maximum sharpness, mechanical/tech art |
| `ultrasharp` | 4x-UltraSharp | High-def balanced sharpness |
| `siax` | 4x_NMKD-Siax_200k | Natural photo texture |
| `nomos` | 4xNomos8kSC | Natural photo, soft detail |
| `esrgan` | realesrgan-x4plus | Classic Real-ESRGAN general purpose |
| `anime` | realesrgan-x4plus-anime | Flat art, vectors, logos, anime |

## File Locations

- **Binary**: `~/.local/share/aethelark/realesrgan/realesrgan-ncnn-vulkan`
- **Models**: `~/.local/share/aethelark/realesrgan/models/`
- **Script**: `~/.local/bin/merch-upscale`
- **Symlinks**: `brand-upscale`, `dtg-upscale` (both in `~/.local/bin/`)

## Supported Input Formats

`.png`, `.jpg`, `.jpeg`, `.webp`

## Output Naming

- Single file: `<stem>_300dpi_master.png` (same directory as input)
- Directory: `<input_dir>/polished_300dpi_masters/<stem>_300dpi_master.png`
- Custom: `-o <path>` overrides default naming
