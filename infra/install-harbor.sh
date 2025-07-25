#!/bin/bash

set -euo pipefail

# Configuration
HARBOR_NS="harbor"
HARBOR_RELEASE="harbor"
HARBOR_HOST="harbor.local"
HARBOR_PASSWORD="Admin12345"

echo "🔍 Checking if Harbor is already installed..."

if helm status "$HARBOR_RELEASE" -n "$HARBOR_NS" &>/dev/null; then
  echo "⚠️ Harbor release already exists in namespace '$HARBOR_NS'."
  read -p "❓ Do you want to uninstall it and reinstall from scratch? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "🧽 Uninstalling existing Harbor release and namespace..."
    helm uninstall "$HARBOR_RELEASE" -n "$HARBOR_NS" || true
    kubectl delete ns "$HARBOR_NS" || true
    sleep 5
  else
    echo "❌ Aborting installation. Nothing changed."
    exit 0
  fi
fi

echo "🚀 Creating namespace: $HARBOR_NS"
kubectl create ns "$HARBOR_NS"

echo "📦 Installing Harbor with Helm..."
helm install "$HARBOR_RELEASE" harbor/harbor \
  -n "$HARBOR_NS" \
  --set expose.ingress.hosts.core="$HARBOR_HOST" \
  --set expose.type=ingress \
  --set expose.ingress.ingressClassName=nginx \
  --set externalURL="http://$HARBOR_HOST" \
  --set harborAdminPassword="$HARBOR_PASSWORD"

echo "⏳ Waiting for Harbor pods to be ready..."
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/name=harbor -n "$HARBOR_NS" --timeout=300s

# Add to /etc/hosts if needed
if ! grep -q "$HARBOR_HOST" /etc/hosts; then
  echo "🛠️ Adding $HARBOR_HOST to /etc/hosts (requires sudo)..."
  echo "127.0.0.1 $HARBOR_HOST" | sudo tee -a /etc/hosts
else
  echo "✅ $HARBOR_HOST already present in /etc/hosts"
fi

echo ""
echo "✅ Harbor installed successfully!"
echo "🌍 Access: http://$HARBOR_HOST"
echo "🔐 Login: admin / $HARBOR_PASSWORD"
