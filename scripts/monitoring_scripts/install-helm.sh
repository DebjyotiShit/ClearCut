#!/bin/bash

# ------------------------------------------------------------------------------
# Helm Installer Script 
# Author: Debjyoti Shit
# Description: Installs the latest stable version of Helm on Ubuntu/Debian.
# ------------------------------------------------------------------------------

set -euo pipefail

HELM_SCRIPT_URL="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
HELM_SCRIPT="get_helm.sh"

echo "Updating package index..."
sudo apt-get update -y > /dev/null

echo "Downloading official Helm install script..."
if curl -fsSL -o "$HELM_SCRIPT" "$HELM_SCRIPT_URL"; then
  echo "Helm install script downloaded successfully."
else
  echo "Failed to download Helm install script."
  exit 1
fi

echo "Making script executable..."
chmod +x "$HELM_SCRIPT"

echo "Running Helm installer..."
./"$HELM_SCRIPT"

echo "Cleaning up..."
rm -f "$HELM_SCRIPT"

echo "Verifying Helm installation..."
if command -v helm >/dev/null 2>&1; then
  echo "Helm installed successfully! Version: $(helm version --short)"
else
  echo "Helm installation failed."
  exit 1
fi
