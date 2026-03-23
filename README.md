# DevOps Local Stack (Flask + Docker + PostgreSQL)

## 📌 Overview
This project demonstrates a production-like DevOps setup using a Flask application containerized with Docker and deployed using docker-compose with PostgreSQL.

---

## 🏗 Architecture

App Container → PostgreSQL Container (Docker Network)

---

## ⚙️ Tech Stack
- Python (Flask)
- Docker (Multi-stage build)
- Docker Compose
- PostgreSQL

---

## 🚀 Features
- Multi-stage Docker build
- Non-root container user
- Healthcheck endpoint
- Environment variable configuration
- Container-to-container communication

---

## ▶️ How to Run

```bash
docker compose up --build# devops-local-stack

## 🔐 Configuration Management

This project uses Kubernetes ConfigMap and Secret:

- ConfigMap → Stores non-sensitive configuration (DB_HOST, DB_NAME, DB_USER)
- Secret → Stores sensitive data (DB_PASS)

Secrets are base64 encoded before being stored in Kubernetes.

### Example:

```bash
echo -n "password" | base64
