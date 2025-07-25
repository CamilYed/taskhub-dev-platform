# 🚀 TaskHub Dev Platform

A fully containerized and extensible microservice development platform designed for local development and CI/CD experimentation using **Kubernetes**, **Harbor**, and more.

---

## 📌 Overview

**TaskHub Dev Platform** is a modular system for building modern container-based applications locally. It enables rapid prototyping, development, and deployment workflows with:

- 🔧 Infrastructure automation (`infra/`)
- 🧱 Modular microservices (backend, frontend, etc.)
- 📦 Internal Docker registry via Harbor
- 🛡️ Support for CI/CD tooling (e.g., Bamboo, GitHub Actions)
- 🌐 DNS via `/etc/hosts` with domains like `harbor.local`

---

## 📁 Repository Structure

| Repository | Description | Status |
|-----------|-------------|--------|
| [`taskhub-dev-platform`](https://github.com/CamilYed/taskhub-dev-platform) | Infrastructure provisioning, Harbor install, ingress setup | ✅ DONE |
| [`taskhub-api`](https://github.com/CamilYed/taskhub-api) | Core backend microservices (business logic, APIs, DB) | ⬜ Planned |
| [`taskhub-web`](https://github.com/CamilYed/taskhub-web) | Frontend SPA (Angular or React) | ⬜ Planned |

---

## 📋 Current Progress

### ✅ Done

- [x] K3d local cluster setup
- [x] Harbor installation via Helm
- [x] Ingress configured (`harbor.local`)
- [x] Harbor UI accessible with login (`admin / Admin12345`)
- [x] `.gitignore` and GitHub repo created: [`taskhub-dev-platform`](https://github.com/CamilYed/taskhub-dev-platform)

### 🔧 In Progress

- [ ] Finalize `install-harbor.sh` improvements (progress bar, retry logic, etc.)
- [ ] Template `.env` and Helm `values.yaml` structure
- [ ] Setup default project(s) in Harbor after install
- [ ] Add Makefile or wrapper for consistent CLI commands

### 📦 Planned

- [ ] `taskhub-api`
  - [ ] REST API or GraphQL
  - [ ] PostgreSQL/MongoDB
  - [ ] Helm chart per service
- [ ] `taskhub-web`
  - [ ] Angular SPA or React frontend
  - [ ] Tailwind, i18n
  - [ ] API integration
- [ ] CI/CD (Bamboo / GitHub Actions)
- [ ] Monitoring (Prometheus, Grafana)
- [ ] Secret management (Sealed Secrets, SOPS)

---

## 🛠 Usage

### 🔄 Install Harbor (local registry)

```bash
cd infra/
./install-harbor.sh
```

> Installs Harbor into a local `k3d` Kubernetes cluster and exposes it via `http://harbor.local`.

Login credentials:

- Username: `admin`
- Password: `Admin12345`

### 🔁 Uninstall

```bash
./install-harbor.sh
# You will be prompted to uninstall if Harbor is detected.
```

---

## 🧠 Architecture (planned)

```
+------------------------+
|     taskhub-web        |
|   (Angular / React)    |
+-----------+------------+
            |
            v
+-----------+------------+
|    taskhub-api          |
|   (REST API, DB etc.)   |
+-----------+------------+
            |
            v
+------------------------+
|      Harbor Registry   |
|    Local Docker store  |
+------------------------+
```

---

## 🔗 Useful Links

- 🌐 [Harbor Docs](https://goharbor.io/docs/)
- 🐳 [k3d](https://k3d.io/)
- 🧪 [Helm](https://helm.sh/)
- ☸️ [Kubernetes](https://kubernetes.io/)

---

## 🧾 License

MIT © CamilYed
