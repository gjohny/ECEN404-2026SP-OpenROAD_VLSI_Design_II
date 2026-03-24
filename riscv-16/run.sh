#!/usr/bin/env bash
# Compatible with WSL
# Usage: ./run_unit.sh <unit_name>
# Example: ./run_unit.sh ALU

EXPECTED_DIR="riscv-16"
CURRENT_DIR=$(basename "$PWD")

if [ "$CURRENT_DIR" != "$EXPECTED_DIR" ]; then
  echo "[!] ⚠️  You are not inside the '$EXPECTED_DIR' directory."
  echo "    Current directory: '$CURRENT_DIR'"

  # Try to detect if riscv-16 exists nearby
  if [ -d "$EXPECTED_DIR" ]; then
    echo "[*] Found '$EXPECTED_DIR' in the current directory."
    echo "    Please run this script again *after changing directory*:"
    echo "    cd $EXPECTED_DIR"
  elif [ -d "../$EXPECTED_DIR" ]; then
    echo "[*] Found '$EXPECTED_DIR' one level up."
    echo "    Please run:"
    echo "    cd ../$EXPECTED_DIR"
  else
    echo "[!] Could not locate '$EXPECTED_DIR' in current or parent directory."
    echo "    Make sure you are running this script from within the riscv-16 project folder."
  fi

  exit 1
fi

# Check argument
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: $0 <unit_name> [--wave]"
  exit 1
fi

UNIT=$1
OPEN_WAVE=false

if [ $# -eq 2 ]; then
  if [ "$2" = "--wave" ]; then
    OPEN_WAVE=true
  else
    echo "Unknown option: $2"
    echo "Usage: $0 <unit_name> [--wave]"
    exit 1
  fi
fi

IVERILOG_DIR="./tb/iverilog"
WAVEFORM_DIR="./tb/waveform"

# --- Ensure output directories exist ---
mkdir -p "$IVERILOG_DIR" "$WAVEFORM_DIR"

# --- Define file paths ---
SRC_FILE="./src/${UNIT}.v"
TB_FILE="./tb/${UNIT}_tb.v"
VVP_FILE="$IVERILOG_DIR/${UNIT}_result.vvp"
OUT_FILE="$IVERILOG_DIR/${UNIT}_out.txt"
VCD_FILE="$WAVEFORM_DIR/${UNIT}.vcd"

echo ""
echo "🔍 Checking required files for '$UNIT'..."
MISSING=false

if [ ! -f "$SRC_FILE" ]; then
  echo "❌ Missing source file: $SRC_FILE"
  MISSING=true
else
  echo "✅ Found source file: $SRC_FILE"
fi

if [ ! -f "$TB_FILE" ]; then
  echo "❌ Missing testbench: $TB_FILE"
  MISSING=true
else
  echo "✅ Found testbench: $TB_FILE"
fi

# Optional include check for Parameter.v
if grep -q '`include "Parameter.v"' "$SRC_FILE" 2>/dev/null || grep -q '`include "Parameter.v"' "$TB_FILE" 2>/dev/null; then
  if [ ! -f "./src/Parameter.v" ] && [ ! -f "../src/Parameter.v" ]; then
    echo "⚠️  Warning: 'Parameter.v' included but not found."
  else
    echo "✅ Found Parameter.v include file."
  fi
fi

if [ "$MISSING" = true ]; then
  echo "❌ One or more required files missing. Aborting."
  exit 1
else
  echo "✅ All required files found. Proceeding..."
fi
echo ""

# Define file paths
VVP_FILE="$IVERILOG_DIR/${UNIT}_result.vvp"
OUT_FILE="$IVERILOG_DIR/${UNIT}_out.txt"
VCD_FILE="$WAVEFORM_DIR/${UNIT}.vcd"

# ---- Step 1: Compile ----
echo "[*] Compiling $UNIT..."

if [ "$UNIT" = "top" ]; then
  echo "[*] Detected top-level build. Compiling all RTL files..."
  iverilog -g2012 -I ./src -o "$VVP_FILE" ./src/*.v "./tb/${UNIT}_tb.v"
else
  echo "[*] Detected unit-level build. Compiling ${UNIT}.v only..."
  iverilog -g2012 -I ./src -o "$VVP_FILE" "./src/${UNIT}.v" "./tb/${UNIT}_tb.v"
fi

if [ $? -ne 0 ]; then
  echo "[!] ❌ Compilation failed for $UNIT"
  exit 1
else
  echo "✅ Compilation successful: ${UNIT}_result.vvp created."
fi

# ---- Step 2: Simulate ----
echo "[*] Running simulation..."
# Redirect both stdout and stderr to tee for logging
vvp "$VVP_FILE" 2>&1 | tee "$OUT_FILE"
if [ $? -ne 0 ]; then
  echo "❌ Simulation failed for ${UNIT}."
  exit 1
else
  echo "✅ Simulation complete: output saved to ${OUT_FILE}."
fi

# ---- Step 3: Launch GTKWave (if available) ----
if [ "$OPEN_WAVE" = true ] && [ -f "$VCD_FILE" ]; then
  echo "[*] Opening GTKWave for $VCD_FILE..."
  # For WSL, gtkwave must be accessible via PATH and X server must be running
  if command -v gtkwave >/dev/null 2>&1; then\
    echo "✅ GTKWave launched for ${VCD_FILE}."
    echo "Ctrl+Q (Cmd+Q on MacOS) to exit GTKWave."
    # Run in background so terminal remains usable
    nohup gtkwave "$VCD_FILE" >/dev/null 2>&1 &
  else
    echo "[!] GTKWave not found in PATH."
    echo "    To install: sudo apt install gtkwave"
    echo "    (You must also have an X server like VcXsrv or Xming running on Windows)"
  fi
else
  echo "[!] No VCD file found: $VCD_FILE OR --wave option not specified. Skipping GTKWave launch."
fi

echo "[*] Done."
