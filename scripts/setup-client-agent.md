# Client PC onboarding guide

Use this process for each client system.

## 1) Add device group

1. Log in to MeshCentral web UI as admin.
2. Create a device group per customer/site.
3. Set policies (remote desktop allowed, terminal, file access, etc.).

## 2) Generate install command

1. Open the target device group.
2. Click **Add Agent**.
3. Choose client OS (Windows/Linux/macOS).
4. Copy install command or installer package.

## 3) Install agent on client PC

- Run installer with admin/root permissions.
- Ensure outbound connectivity from client to central server on TCP 443.
- After install, the device appears in the server UI.

## 4) Remote access

1. In device list, click the client machine.
2. Open **Desktop** for remote control.
3. Use policy/user roles for least privilege.

## 5) Administrative privilege behavior

- For unattended full-control sessions, install the agent as a system service.
- On Windows, configure UAC/session permissions as required.
- On Linux, use privilege escalation policy (`sudo`) for admin operations.

## 6) Hardening checklist

- Require MFA for administrators.
- Disable unused features (SSH/files if not needed).
- Separate customer groups with scoped operator accounts.
- Enable auditing and periodic log review.
