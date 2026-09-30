# Production Kubernetes GitOps Microservices Architecture

Declarative Kubernetes deployment baseline implementing GitOps multi-environment overlays (`base` vs `production`), Zero-Downtime Rolling Updates, Hardened Pod Security Standards, and Ingress TLS.

---

## 🎯 Architecture & Design Highlights

1. **GitOps Overlay Pattern (Kustomize)**:
   - `base/`: Core immutable resource templates (Deployment, Service, ConfigMap, Ingress).
   - `overlays/production/`: Environment-specific patches (replica scale-up to 3, adjusted resource limits).

2. **Pod Security & CIS Compliance**:
   - `runAsNonRoot: true` with dedicated UID `10001`.
   - `readOnlyRootFilesystem: true` to prevent in-container persistent malware execution.
   - `drop: ["ALL"]` Linux capabilities to prevent container escape.

3. **High Availability & Zero-Downtime Deployment**:
   - `maxSurge: 1` and `maxUnavailable: 0` strategy ensures zero packet drops during rolling updates.
   - Dual health probes:
     - `livenessProbe`: Restarts deadlocked containers automatically.
     - `readinessProbe`: Directs traffic only to fully warmed-up pods.

---

## 📁 Repository Structure

```text
├── base/
│   ├── deployment.yaml           # Hardened multi-replica deployment
│   ├── service-ingress.yaml      # ClusterIP service, ConfigMap, and Ingress TLS
│   └── kustomization.yaml        # Base resource bundle
├── overlays/
│   └── production/               # Production patches & replica scaling
└── .github/workflows/
    └── k8s-ci.yml                # Automated Kustomize linting & validation
```

---
**Author**: Muhammad Nur Ashiddiqi  
**Portfolio**: [muhammadnurashiddiqi.my.id](https://muhammadnurashiddiqi.my.id)
