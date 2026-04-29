#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 '<meshcentral-agent-install-url>'"
  echo "Example: $0 'https://server/meshagents?id=abc'"
  exit 1
fi

AGENT_URL="$1"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cd "$TMP_DIR"
curl -fsSL "$AGENT_URL" -o meshagent
chmod +x meshagent
sudo ./meshagent -install
sudo systemctl enable meshagent || true
sudo systemctl start meshagent || true

echo "MeshAgent installed. Verify in MeshCentral device list."
