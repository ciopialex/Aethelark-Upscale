# ==============================================================================
# Aethelark-Upscale Automated Installer for Windows (PowerShell)
# GPU-Accelerated Image Super-Resolution & 300 DPI Print Engine
# Created by Alexandru Cioponea (Aethelark)
# https://github.com/ciopialex/Aethelark-Upscale
# ==============================================================================

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host "                Aethelark-Upscale Windows Installer                " -ForegroundColor Cyan
Write-Host "         GPU Image Super-Resolution & 300 DPI Print Engine         " -ForegroundColor Cyan
Write-Host "                  Designed for AI Agents & Creators                " -ForegroundColor Cyan
Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Check for Python
Write-Host "▶ Checking Python installation..." -ForegroundColor Yellow
$PythonCmd = $null
if (Get-Command python -ErrorAction SilentlyContinue) {
    $PythonCmd = "python"
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    $PythonCmd = "py"
} else {
    Write-Host "❌ Error: Python 3 is required. Please install Python from https://www.python.org or the Microsoft Store." -ForegroundColor Red
    exit 1
}

Write-Host "  ↳ Found: $(& $PythonCmd --version)" -ForegroundColor Green

# 2. Directories
$InstallDir = "$env:LOCALAPPDATA\aethelark\realesrgan"
$ModelsDir  = "$InstallDir\models"
$BinDir     = "$env:LOCALAPPDATA\Programs\aethelark\bin"

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
New-Item -ItemType Directory -Force -Path $ModelsDir  | Out-Null
New-Item -ItemType Directory -Force -Path $BinDir     | Out-Null

# 3. Download Real-ESRGAN Vulkan Windows Engine
$EsrganExe = "$InstallDir\realesrgan-ncnn-vulkan.exe"
if (-not (Test-Path $EsrganExe)) {
    Write-Host "`n▶ Downloading Real-ESRGAN Vulkan Windows binary..." -ForegroundColor Yellow
    $ZipUrl = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesrgan-ncnn-vulkan-20220424-windows.zip"
    $ZipPath = "$env:TEMP\realesrgan-windows.zip"
    
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing
    Expand-Archive -Path $ZipPath -DestinationPath $InstallDir -Force
    Remove-Item -Path $ZipPath -Force
    Write-Host "✓ Real-ESRGAN Windows engine installed." -ForegroundColor Green
} else {
    Write-Host "`n✓ Real-ESRGAN Windows binary already present." -ForegroundColor Green
}

# 4. Download Neural Models
function Download-Model($Name, $BaseUrl) {
    $BinPath = "$ModelsDir\$Name.bin"
    $ParamPath = "$ModelsDir\$Name.param"

    if (-not (Test-Path $BinPath) -or -not (Test-Path $ParamPath)) {
        Write-Host "  ↳ Downloading neural model: $Name..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri "$BaseUrl.bin" -OutFile $BinPath -UseBasicParsing
        Invoke-WebRequest -Uri "$BaseUrl.param" -OutFile $ParamPath -UseBasicParsing
    } else {
        Write-Host "  ↳ Model $Name is ready." -ForegroundColor Green
    }
}

Write-Host "`n▶ Checking neural models in $ModelsDir..." -ForegroundColor Yellow

# NMKD Superscale
Download-Model "4x_NMKD-Superscale-SP_178000_G" `
    "https://raw.githubusercontent.com/upscayl/custom-models/main/models/4x_NMKD-Superscale-SP_178000_G"

# NMKD Siax
Download-Model "4x_NMKD-Siax_200k" `
    "https://raw.githubusercontent.com/upscayl/custom-models/main/models/4x_NMKD-Siax_200k"

# Nomos
Download-Model "4xNomos8kSC" `
    "https://raw.githubusercontent.com/upscayl/custom-models/main/models/4xNomos8kSC"

# UltraSharp
$UltraSharpBin = "$ModelsDir\4x-UltraSharp.bin"
$UltraSharpParam = "$ModelsDir\4x-UltraSharp.param"
if (-not (Test-Path $UltraSharpBin) -or -not (Test-Path $UltraSharpParam)) {
    Write-Host "  ↳ Downloading neural model: 4x-UltraSharp..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://huggingface.co/Kim2091/UltraSharp/resolve/main/NCNN/4x-UltraSharp-fp16.bin" -OutFile $UltraSharpBin -UseBasicParsing
    Invoke-WebRequest -Uri "https://huggingface.co/Kim2091/UltraSharp/resolve/main/NCNN/4x-UltraSharp-fp16.param" -OutFile $UltraSharpParam -UseBasicParsing
} else {
    Write-Host "  ↳ Model 4x-UltraSharp is ready." -ForegroundColor Green
}

# 5. Install Python dependencies
Write-Host "`n▶ Installing Python dependencies (Pillow, numpy, opencv-python-headless)..." -ForegroundColor Yellow
& $PythonCmd -m pip install --upgrade --quiet pillow numpy opencv-python-headless

# 6. Copy aethelark-upscale script & create Windows batch wrappers
Write-Host "`n▶ Installing CLI executable to $BinDir..." -ForegroundColor Yellow
$TargetPy = "$BinDir\aethelark-upscale"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if (Test-Path "$ScriptDir\aethelark-upscale") {
    Copy-Item -Path "$ScriptDir\aethelark-upscale" -Destination $TargetPy -Force
} else {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ciopialex/Aethelark-Upscale/main/aethelark-upscale" -OutFile $TargetPy -UseBasicParsing
}

# Create .cmd / .bat wrappers so commands work cleanly in CMD and PowerShell
$WrapperContent = @"
@echo off
$PythonCmd "%~dp0aethelark-upscale" %*
"@

Set-Content -Path "$BinDir\aethelark-upscale.bat" -Value $WrapperContent -Force
Set-Content -Path "$BinDir\brand-upscale.bat" -Value $WrapperContent -Force
Set-Content -Path "$BinDir\merch-upscale.bat" -Value $WrapperContent -Force

# 7. Add BinDir to User PATH if missing
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -notlike "*$BinDir*") {
    Write-Host "  ↳ Adding $BinDir to User PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("Path", "$UserPath;$BinDir", "User")
    $env:Path += ";$BinDir"
}

Write-Host ""
Write-Host "==================================================================" -ForegroundColor Green
Write-Host "🎉 Aethelark-Upscale installed successfully on Windows!" -ForegroundColor Green
Write-Host "==================================================================" -ForegroundColor Green
Write-Host "Commands available in Command Prompt & PowerShell:"
Write-Host "  • aethelark-upscale"
Write-Host "  • brand-upscale"
Write-Host "  • merch-upscale"
Write-Host ""
Write-Host "Quick test:"
Write-Host "  aethelark-upscale --help"
Write-Host "  aethelark-upscale my-image.png --organic"
Write-Host ""
