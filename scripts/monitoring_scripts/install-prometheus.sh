#!/bin/bash

# -----------------------------------------------------------------------------
# Prometheus installation script for Kubernetes
# Maintained by: Debjyoti Shit
# Description: This script installs Prometheus in a Kubernetes cluster using Helm.
# -----------------------------------------------------------------------------
set -e

echo "Creating 'monitoring' namespace if not exists..."
kubectl create namespace monitoring 2>/dev/null || echo "Namespace exists"

echo "Adding Prometheus Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "Installing Prometheus..."
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --set server.service.type=NodePort \
  --set alertmanager.enabled=false \
  --set pushgateway.enabled=false
echo "Prometheus installation complete!"