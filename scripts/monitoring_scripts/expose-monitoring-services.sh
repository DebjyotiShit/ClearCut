#!/bin/bash
# -----------------------------------------------------------------------------
# Expose Prometheus and Grafana services as NodePort in Kubernetes 
# Maintained by: Debjyoti Shit
# Description: This script patches Prometheus and Grafana services to NodePort type in the monitoring namespace.
# -----------------------------------------------------------------------------     


set -e

echo "Patching services to NodePort (if not already)..."

kubectl patch svc prometheus-server -n monitoring -p '{"spec": {"type": "NodePort"}}' || true
kubectl patch svc grafana -n monitoring -p '{"spec": {"type": "NodePort"}}' || true

echo "Services exposed as NodePort:"
kubectl get svc -n monitoring
