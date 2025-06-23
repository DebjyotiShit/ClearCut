#!/bin/bash

# -----------------------------------------------------------------------------
# Prometheus Installer Script
# Maintained by: Debjyoti Shit
# Description: Installs Prometheus monitoring system on Ubuntu server.
# -----------------------------------------------------------------------------

set -e  # Exit on any error

PROMETHEUS_VERSION="2.51.2"
PROM_USER="prometheus"
PROM_GROUP="prometheus"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/prometheus"
DATA_DIR="/var/lib/prometheus"
TMP_DIR="/tmp"
ARCHIVE_NAME="prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"
DOWNLOAD_URL="https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/${ARCHIVE_NAME}"

echo "🔄 Updating system and installing dependencies..."
sudo apt update -y
sudo apt install -y wget tar curl

# Create Prometheus user and group if not exists
if ! id "$PROM_USER" &>/dev/null; then
  echo "👤 Creating user and group '$PROM_USER'..."
  sudo useradd --no-create-home --shell /bin/false $PROM_USER
else
  echo "👤 User '$PROM_USER' already exists. Skipping user creation."
fi

# Create necessary directories
echo "📁 Ensuring necessary directories exist..."
for dir in "$CONFIG_DIR" "$DATA_DIR" "$CONFIG_DIR/data"; do
  sudo mkdir -p "$dir"
done

# Download and extract Prometheus
echo "⬇️ Downloading Prometheus v${PROMETHEUS_VERSION}..."
cd $TMP_DIR
if [ -f "$ARCHIVE_NAME" ]; then
  echo "✅ Archive already downloaded. Skipping download."
else
  wget -q "$DOWNLOAD_URL"
fi

echo "📦 Extracting Prometheus..."
tar -xzf "$ARCHIVE_NAME"
cd "prometheus-${PROMETHEUS_VERSION}.linux-amd64"

# Move binaries
echo "🚚 Installing Prometheus binaries..."
sudo cp prometheus promtool "$INSTALL_DIR"

# Move configuration and web files
echo "📁 Copying configuration and console files..."
sudo cp -r consoles console_libraries "$CONFIG_DIR"
sudo cp prometheus.yml "$CONFIG_DIR"

# Set correct ownership
echo "🔐 Setting ownership to '$PROM_USER'..."
sudo chown -R $PROM_USER:$PROM_GROUP "$CONFIG_DIR" "$DATA_DIR"
sudo chown $PROM_USER:$PROM_GROUP "$INSTALL_DIR/prometheus" "$INSTALL_DIR/promtool"

# Create systemd service
echo "🛠️ Creating Prometheus systemd service..."
SERVICE_FILE="/etc/systemd/system/prometheus.service"
sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=Prometheus Monitoring System
Wants=network-online.target
After=network-online.target

[Service]
User=$PROM_USER
Group=$PROM_GROUP
Type=simple
ExecStart=$INSTALL_DIR/prometheus \\
  --config.file=$CONFIG_DIR/prometheus.yml \\
  --storage.tsdb.path=$DATA_DIR \\
  --web.console.templates=$CONFIG_DIR/consoles \\
  --web.console.libraries=$CONFIG_DIR/console_libraries

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start service
echo "🚀 Starting Prometheus..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl restart prometheus

# Show service status
echo "✅ Prometheus installation completed successfully!"
sudo systemctl status prometheus --no-pager
