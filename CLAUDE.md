# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GitOps homelab Kubernetes cluster repository. Flux CD watches the `main` branch and reconciles the `./manifests` directory. The cluster runs on **Talos Linux** (immutable Kubernetes OS).

## Key Commands

### Secret Management
Plaintext secrets live in `secrets/` (not committed to git). After editing a secret, encrypt it to a `sealedsecret.yaml` using:
```bash
# Encrypt a single secret
kubeseal -f secrets/<app>/secret.yaml -o yaml | grep -v creationTimestamp > manifests/<app>/sealedsecret.yaml

# Or use the helper script (run from repo root)
./hack/generate-secrets.sh
```

### Bootstrap Flux
Regenerate the `gotk-components.yaml` file:
```bash
./hack/bootstrap.sh
```

### Terraform (OCI image builds)
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Architecture

### GitOps Flow
- Flux watches `main` branch at `./manifests` path (10-minute interval)
- Each application has its own subdirectory under `manifests/` with a `kustomization.yaml`
- `manifests/flux-system/sources.yaml` defines all HelmRepository and GitRepository sources
- Two automated update mechanisms coexist:
  - **Renovate bot** manages most Helm chart version updates (configured in `renovate.json`)
  - **Flux Image Update Automation** manages some apps (cert-manager, immich, jellyfin) via `imageupdates.yaml` files — these push to `flux/updates/<app>` branches

### Manifest Structure
Each application directory typically contains:
- `helm.yaml` — HelmRelease resource
- `kustomization.yaml` — Kustomize entrypoint listing all resources
- `namespace.yaml` — Namespace definition
- `sealedsecret.yaml` — Encrypted secrets (safe to commit)
- Optional: `imageupdates.yaml`, `storage.yaml`, `ingress.yaml`

### Infrastructure Components
| Component | Role |
|-----------|------|
| **MetalLB** | L2 load balancer, IP pool 192.168.1.90–99 |
| **Traefik** | Ingress controller (HTTP→HTTPS redirect, HTTP3 enabled) |
| **cert-manager** | TLS via Let's Encrypt, Cloudflare DNS-01 challenge, cluster issuer `letsencrypt-production` |
| **democratic-csi** | Storage from TrueNAS at 192.168.1.100 — two storage classes: `truenas-iscsi-csi` and `truenas-nfs-csi` |
| **Sealed Secrets** | Bitnami kubeseal for encrypting secrets in git |
| **Velero** | Backups to Backblaze B2 bucket `seymour-family-backup` |
| **Tailscale** | Some services (e.g., Grafana) use Tailscale LoadBalancer class |

### Network
- Domain: `seymour.family`
- Cluster VIP (Talos): `192.168.1.200`
- TrueNAS: `192.168.1.100`
- External PostgreSQL (for Synapse/MAS): `192.168.1.204`

### Applications
- **authentik** — SSO/identity provider (with a static-web-server sidecar for WebFinger/well-known)
- **synapse** — Matrix homeserver via ESS Community `matrix-stack` chart; uses Matrix Authentication Service (MAS) backed by Authentik OIDC; bridges: mautrix-signal, mautrix-gmessages, mautrix-discord deployed as separate Deployments
- **immich** — Photo management
- **nextcloud** — File sync/storage
- **jellyfin** — Media server with Intel GPU passthrough (intel-device-plugins)
- **pinchflat** — YouTube downloader (raw Deployment, not a HelmRelease)
- **observability** — kube-prometheus-stack (Prometheus + Grafana)
- **redis** — Standalone Redis (raw manifests, not Helm)

### Talos Configuration
- `talos/patches/controlplane.yaml` — Enables scheduling on control plane nodes, configures eth0 with DHCP and VIP 192.168.1.200

### Terraform
Uses the Chainguard `apko` provider to build minimal OCI base images pushed to `docker.io/firstofth300/`:
- `java:21-jre` — OpenJDK 21
- `node:22` — Node.js 22
