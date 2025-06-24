#!/bin/bash

# -----------------------------------------------------------------------------
# Script to fetch Grafana admin password from Kubernetes secret 
# Maintained by: Debjyoti Shit
# Description: This script retrieves the Grafana admin password from the Kubernetes secret in the monitoring namespace.
# ----------------------------------------------------------------------------- 


set -e

echo "Fetching Grafana admin password..."
kubectl get secret --namespace monitoring grafana \
  -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
echo "Grafana admin password retrieved successfully."