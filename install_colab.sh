#!/bin/bash
# NDT3 Installation Script for Google Colab
# This script installs NDT3 with all dependencies in the correct order

set -e  # Exit on error

echo "================================================"
echo "NDT3 Installation for Google Colab"
echo "================================================"

# 1. Install NumPy first (critical for binary compatibility)
echo ""
echo "📦 Installing NumPy < 2.0..."
pip install -q "numpy<2.0"

# 2. Install PyTorch (keep Colab's version if available)
echo ""
echo "🔥 Checking PyTorch..."
python -c "import torch; print(f'PyTorch {torch.__version__} already installed')" 2>/dev/null || {
    echo "Installing PyTorch..."
    pip install -q torch torchvision
}

# 3. Install Flash Attention
echo ""
echo "⚡ Installing Flash Attention..."
pip install -q flash-attn --no-build-isolation

# 4. Install other dependencies
echo ""
echo "📚 Installing dependencies..."
pip install -q -r requirements.txt

# 5. Install NDT3 (without dependencies, we already installed them)
echo ""
echo "📦 Installing NDT3..."
pip install -q -e . --no-deps

# 6. CRITICAL: Force NumPy < 2.0 AFTER everything (some packages try to upgrade it)
echo ""
echo "🔧 FORCING NumPy < 2.0 (critical for binary compatibility)..."
pip install -q "numpy<2.0" --force-reinstall --no-deps

# 7. Verify NumPy version
echo ""
NUMPY_VERSION=$(python -c "import numpy; print(numpy.__version__)")
echo "✓ Final NumPy version: $NUMPY_VERSION"

if [[ "$NUMPY_VERSION" == 2.* ]]; then
    echo "⚠️  WARNING: NumPy 2.x detected! Forcing downgrade..."
    pip uninstall -y numpy
    pip install -q "numpy==1.26.4"
fi

echo ""
echo "================================================"
echo "✅ Installation complete!"
echo "================================================"
echo ""
echo "Verify installation:"
echo "  python -c 'from context_general_bci.model import load_from_checkpoint; print(\"✓ NDT3 OK\")'"

