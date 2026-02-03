#!/bin/bash

# Copy VS Code Settings
mkdir -p .vscode
cp -n .devcontainer/settings.json .vscode
# Copy Github CI
mkdir -p .github/workflows
cp -n .devcontainer/ci/latex_build.yml .github/workflows
# Copy Gitlab CI
cp -n .devcontainer/ci/.gitlab-ci.yml ./

# Download platform-independent ltex-ls for LTeX extension (works on both x64 and ARM64)
LTEX_VERSION="15.2.0"
LTEX_EXT_DIR="$HOME/.vscode-server/extensions/valentjn.vscode-ltex-13.1.0"
LTEX_LS_DIR="$LTEX_EXT_DIR/lib/ltex-ls-$LTEX_VERSION"

if [ -d "$LTEX_EXT_DIR" ] && [ ! -d "$LTEX_LS_DIR" ]; then
    echo "Downloading platform-independent ltex-ls $LTEX_VERSION..."
    mkdir -p "$LTEX_EXT_DIR/lib"
    curl -L --retry 3 -o /tmp/ltex-ls.tar.gz \
        "https://github.com/valentjn/ltex-ls/releases/download/$LTEX_VERSION/ltex-ls-$LTEX_VERSION.tar.gz" \
        && tar -xzf /tmp/ltex-ls.tar.gz -C "$LTEX_EXT_DIR/lib" \
        && rm -f /tmp/ltex-ls.tar.gz \
        && echo "ltex-ls installed successfully." \
        || echo "Warning: Failed to download ltex-ls. LTeX will attempt to download it on first use."
fi
