#!/usr/bin/env sh
set -eu

if [ -z "${MESH_AGENT_URL:-}" ]; then
  echo "MESH_AGENT_URL is required (use MeshCentral Add Agent link)."
  exit 1
fi

DEVICE_NAME="${MESH_DEVICE_NAME:-docker-linux-client}"
STATE_DIR="/var/lib/meshagent"
BIN_DIR="/opt/meshagent"

mkdir -p "$STATE_DIR" "$BIN_DIR"
cd "$BIN_DIR"

curl -fsSL "$MESH_AGENT_URL" -o meshagent
chmod +x meshagent

# MeshAgent manages its own service/runtime; container remains alive for operator visibility.
./meshagent -fullinstall --displayName "$DEVICE_NAME" || true

echo "MeshAgent install command executed. Keeping container alive."
tail -f /dev/null
