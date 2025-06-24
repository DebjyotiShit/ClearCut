#!/bin/bash

# -----------------------------------------------------------------------------
# Full monitoring stack setup script for Kubernetes
# Maintained by: Debjyoti Shit
# Description: This script sets up a full monitoring stack including Prometheus and Grafana in a Kubernetes cluster.
# -----------------------------------------------------------------------------


set -e

echo "Starting full monitoring stack setup..."

./install-prometheus.sh
./install-grafana.sh

echo "⏳ Waiting 60s for pods to initialize..."
sleep 60

./expose-monitoring-services.sh
./get-grafana-password.sh

echo "Monitoring stack setup complete!"
