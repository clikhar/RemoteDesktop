# Docker-based Centralized Remote Desktop Platform

This repository provides a starter architecture for a **centralized remote desktop solution** where:

- A central server shows all registered client PCs.
- An administrator can click a client and open a remote session.
- Access can run in unattended/admin mode (based on policy and OS permissions).

The implementation uses **MeshCentral** in Docker, which is designed for centralized remote management.

## High-level architecture

- **Central server (Docker host):**
  - `meshcentral`: Web UI + control plane
  - `mongo`: Database for users/devices/config
- **Client PCs:**
  - Install MeshAgent on each client device.
  - Agent connects outbound to central server over TLS.

## Repository structure

- `docker-compose.yml`: Runs central services.
- `meshcentral-data/config.json`: MeshCentral configuration.
- `scripts/setup-client-agent.md`: Client onboarding steps.

## Quick start (central server)

1. Install Docker + Docker Compose plugin.
2. Update `meshcentral-data/config.json`:
   - `cert` should be your public DNS name or static IP.
   - Optional: configure reverse proxy / TLS certs.
3. Start services:

```bash
docker compose up -d
```

4. Open:
   - `https://<your-server>:443` (or mapped port)
5. Create the first admin account from the web portal.

## What about MeshAgent?

MeshAgent runs on each client endpoint (Windows/Linux/macOS). In most deployments it is **not** run as a long-lived Docker container, because it needs direct OS/session access for remote desktop and admin operations.

This repo includes helper installers for endpoints:

- `scripts/install-meshagent-linux.sh`
- `scripts/install-meshagent-windows.ps1`

## MeshAgent as a Docker container (Linux clients)

If you specifically want agent deployment as a container for Linux clients, use `docker-compose.client-agent.yml`.

1. Generate a Linux agent install URL from MeshCentral (**Add Agent**).
2. Create `.env` next to compose file:

```bash
MESH_AGENT_URL=https://your-server/meshagents?id=...
MESH_DEVICE_NAME=client-linux-01
```

3. Start the client agent container:

```bash
docker compose -f docker-compose.client-agent.yml up -d --build
```

> Note: Windows/macOS clients should still use native agents, not containers.

## Client onboarding flow

Use the admin UI to create an agent install link and run the agent on each client machine.
Detailed instructions are in `scripts/setup-client-agent.md`.

## Security recommendations

- Put server behind a firewall and only expose required ports.
- Use a real TLS certificate (Let's Encrypt or enterprise CA).
- Enforce MFA for all admin users.
- Use role-based access control and device groups.
- Keep audit logs enabled.
- Restrict agent permissions by policy where needed.

## Notes on administrative privilege

Remote control with full/admin rights depends on:

- Agent installation mode (service/system)
- OS-level permissions (Windows UAC / Linux sudo context)
- MeshCentral policy settings

This starter includes the infrastructure; privilege behavior is enforced by host OS + agent policy.
