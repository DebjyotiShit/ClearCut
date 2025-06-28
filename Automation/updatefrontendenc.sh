#!/bin/bash

# -----------------------------------------------------------------------------
# Update the frontend environment variables.
# Maintained by: Debjyoti Shit
# Description: Update the frontend environment variables in the .env file.
# -----------------------------------------------------------------------------

set -euo pipefail

# ---------- Configuration ----------
INSTANCE_ID="i-030da7d31a1dbbffc"
ENV_FILE_PATH="../frontend/.env"
AWS_REGION="ap-south-1" 
PORT="4000"
KEY="VITE_BACKEND_URL"

# ---------- Fetch EC2 Public IP ----------
echo "Fetching EC2 public IP for instance: $INSTANCE_ID"
IP_ADDRESS=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$AWS_REGION" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

if [[ -z "$IP_ADDRESS" || "$IP_ADDRESS" == "None" ]]; then
  echo "❌ Could not fetch public IP. Exiting."
  exit 1
fi

# ---------- New Backend URL ----------
NEW_URL="http://${IP_ADDRESS}:${PORT}"
echo "✅ New backend URL will be: $NEW_URL"

# ---------- Check & Update .env.docker ----------
if [[ ! -f "$ENV_FILE_PATH" ]]; then
  echo "❌ .env file not found at $ENV_FILE_PATH"
  exit 1
fi

echo "🔍 Checking current value in .env.docker..."
CURRENT_LINE=$(grep "^$KEY=" "$ENV_FILE_PATH" || true)

if [[ "$CURRENT_LINE" == "$KEY=\"$NEW_URL\"" ]]; then
  echo "✅ No update needed. URL already set to $NEW_URL"
else
  echo "🛠️ Updating $KEY in $ENV_FILE_PATH..."
  sed -i.bak -E "s|^$KEY=.*|$KEY=\"$NEW_URL\"|" "$ENV_FILE_PATH"
  echo "✅ .env updated successfully."
fi
