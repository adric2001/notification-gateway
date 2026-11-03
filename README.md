# 📟 Personal Telegram Webhook Notification Gateway ("Personal Pager")

> A simple, private microservice you can use constantly: anytime you run a long script, backup, model training, or data job, you append one `curl` command to get an instant ping on your phone via Telegram when it finishes or fails.

---

## 🏗️ Architecture Overview

The entire system is designed to be simple, secure, and educational across the full DevOps and cloud-native stack:

```mermaid
flowchart LR
    subgraph Client ["Your Terminal / Script"]
        A["Long Script / Backup / ML Training"] -->|"curl -X POST /notify\n(Bearer Token)"| B["HTTPS Webhook Request"]
    end

    subgraph Edge ["Network Edge & Ingress"]
        B -->|"Port 443 (TLS/SSL)"| C["Let's Encrypt\nCert-Manager"]
        C --> D["NGINX / Traefik Ingress"]
    end

    subgraph Cluster ["K3s Kubernetes Cluster"]
        D -->|"ClusterIP (Port 8000)"| E["K8s Service"]
        E --> F["Pod (FastAPI + Uvicorn)"]
        
        subgraph App ["FastAPI Microservice (< 40 lines)"]
            F -->|"Validate Token & JSON"| G["verify_token()"]
            G -->|"Async HTTP Dispatch"| H["send_telegram_message()"]
        end
    end

    subgraph Mobile ["Telegram"]
        H -->|"api.telegram.org"| I["📱 Your Telegram App\n(Instant Push Notification)"]
    end

    subgraph Monitoring ["Observability"]
        J["Prometheus"] -->|"Scrape /metrics"| E
        J --> K["Grafana Dashboard"]
    end
```

---

## 🗂️ Project Directory Map

Every file in this repository is set up with detailed step-by-step guidance comments to help you write the code yourself:

```text
notification-gateway/
├── .github/
│   └── dependabot.yml              # Automated dependency security bumps
├── .gitignore                      # Ignores .terraform/, *.tfstate, .env, __pycache__/
├── README.md                       # Architecture diagram and onboarding runbook
├── Jenkinsfile                     # Declarative CI/CD pipeline definition
│
├── app/                            # Application source code & tests (Python + Docker)
│   ├── Dockerfile                  # Multi-stage production build (python:3.11-slim)
│   ├── .dockerignore
│   ├── requirements.txt            # Runtime dependencies (FastAPI, uvicorn, httpx, etc.)
│   ├── requirements-dev.txt        # Dev dependencies (pytest, flake8, black, httpx)
│   ├── src/
│   │   ├── __init__.py
│   │   ├── main.py                 # FastAPI initialization, routing, & Prometheus instrumentation
│   │   ├── config.py               # Pydantic BaseSettings loading environment variables
│   │   ├── schemas.py              # Inbound alert request models
│   │   └── services/
│   │       ├── __init__.py
│   │       └── telegram.py         # Async Telegram delivery logic
│   └── tests/
│       ├── __init__.py
│       ├── test_health.py          # /healthz endpoint test
│       └── test_notify.py          # Mocked notification payload delivery tests
│
├── terraform/                      # Infrastructure as Code (AWS provisioner)
│   ├── backend.tf                  # S3 bucket and DynamoDB locking configuration
│   ├── providers.tf                # AWS provider constraints (~> 5.0)
│   ├── variables.tf                # Configurable vars (region, instance_type, allowed_ssh_ip)
│   ├── terraform.tfvars.example    # Example variable values template
│   ├── vpc.tf                      # VPC, internet gateway, public subnets, route tables
│   ├── security_groups.tf          # Inbound/outbound port rules
│   ├── ec2.tf                      # Compute instance, EBS volume, and Elastic IP
│   ├── iam.tf                      # EC2 instance profile and cloudwatch permissions
│   └── outputs.tf                  # Instance public IP, DNS output, and SSH commands
│
├── ansible/                        # Configuration management & server provisioning
│   ├── ansible.cfg                 # Inventory location, SSH timeout, host key checking rules
│   ├── inventory/
│   │   └── hosts.ini               # Dynamic or static target IP from Terraform outputs
│   ├── group_vars/
│   │   └── all.yml                 # Node-wide configuration variables
│   ├── playbooks/
│   │   └── site.yml                # Master orchestration playbook
│   └── roles/
│       ├── common/                 # OS baseline: apt-get update, UFW firewall, fail2ban
│       │   └── tasks/main.yml
│       ├── docker/                 # Containerd / Docker engine setup
│       │   └── tasks/main.yml
│       └── k3s/                    # Lightweight Kubernetes installation and kubeconfig export
│           └── tasks/main.yml
│
├── k8s/                            # Kubernetes orchestration manifests
│   ├── base/
│   │   ├── kustomization.yaml      # Kustomize aggregation file
│   │   ├── namespace.yaml          # Dedicated 'gateway' namespace
│   │   ├── deployment.yaml         # App deployment (2 replicas, resources, liveness/readiness)
│   │   ├── service.yaml            # ClusterIP exposing port 8000
│   │   ├── configmap.yaml          # Non-sensitive app config (log level, retry limits)
│   │   ├── secret.example.yaml     # Base64 secret template for tokens (bot token, auth key)
│   │   ├── ingress.yaml            # NGINX Ingress rules mapping notify.yourdomain.com
│   │   └── servicemonitor.yaml     # CRD instructing Prometheus to scrape /metrics
│   └── cert-manager/
│       ├── cluster-issuer.yaml     # Let's Encrypt production ACME registration
│       └── certificate.yaml        # TLS certificate definition targeting domain
│
├── monitoring/                     # Observability configuration
│   ├── helm/
│   │   └── values-prometheus.yaml  # Customized overrides for kube-prometheus-stack
│   └── dashboards/
│       ├── gateway-metrics.json    # Exported Grafana dashboard (RPS, latency, HTTP errors)
│       └── alert-rules.yaml        # PrometheusRule for downstream alerting (e.g. 5xx rate > 1%)
│
└── scripts/                        # Automation & developer ergonomics
    ├── bootstrap.sh                # Single script to trigger Terraform then run Ansible
    ├── local_run.sh                # Local Docker Compose testing runner
    └── send_test_alert.sh          # Sample curl utility script to trigger test alerts
```

---

## 🎯 Step-by-Step Learning Guide

Follow these stages one at a time:

### Step 1: Getting Your Telegram Credentials
1. Open Telegram and search for `@BotFather`.
2. Send `/newbot`, name your bot (e.g., `MyPersonalPagerBot`), and copy the **Bot Token** (e.g. `123456789:ABCdef...`).
3. Search for `@userinfobot` on Telegram and send `/start` to see your **Chat ID** (e.g. `987654321`).
4. Create a `.env` file in the project root:
   ```env
   API_SECRET_KEY=my-super-secret-key-123
   TELEGRAM_BOT_TOKEN=123456789:ABCdef...
   TELEGRAM_CHAT_ID=987654321
   ```

### Step 2: Build the Python Application (`app/src/`)
1. Open [`app/requirements.txt`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/requirements.txt) and [`app/requirements-dev.txt`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/requirements-dev.txt) to see the packages to install.
2. Open [`app/src/config.py`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/src/config.py) and follow the comments to implement Pydantic settings loading.
3. Open [`app/src/schemas.py`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/src/schemas.py) to write the `AlertRequest` model.
4. Open [`app/src/services/telegram.py`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/src/services/telegram.py) to write `send_telegram_message()` using `httpx`.
5. Open [`app/src/main.py`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/src/main.py) to wire up the `/healthz` and `/notify` routes.
6. Open [`app/tests/`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/tests/) to write unit tests with `pytest`.

### Step 3: Containerize with Docker (`app/Dockerfile`)
1. Follow the comments in [`app/Dockerfile`](file:///Users/adrichall/Desktop/Repos/notification-gateway/app/Dockerfile) to write a 2-stage build:
   - Builder stage: installs wheels into `/install`.
   - Runner stage: copies `/install`, creates a non-root `appuser`, and runs `uvicorn`.

### Step 4: Infrastructure as Code (`terraform/`)
1. Open the files in [`terraform/`](file:///Users/adrichall/Desktop/Repos/notification-gateway/terraform/) in this order:
   - `providers.tf` -> `variables.tf` -> `vpc.tf` -> `security_groups.tf` -> `ec2.tf` -> `iam.tf` -> `outputs.tf`.
2. Follow the comments to configure the AWS cloud resources.

### Step 5: Server Configuration (`ansible/`)
1. Open [`ansible/playbooks/site.yml`](file:///Users/adrichall/Desktop/Repos/notification-gateway/ansible/playbooks/site.yml) and the roles in [`ansible/roles/`](file:///Users/adrichall/Desktop/Repos/notification-gateway/ansible/roles/).
2. Follow the task comments to harden the server, install Docker, and install K3s.

### Step 6: Kubernetes & Ingress (`k8s/`)
1. Open [`k8s/base/`](file:///Users/adrichall/Desktop/Repos/notification-gateway/k8s/base/) and [`k8s/cert-manager/`](file:///Users/adrichall/Desktop/Repos/notification-gateway/k8s/cert-manager/).
2. Write the Deployment, Service, ConfigMap, Ingress, and ClusterIssuer manifests.

### Step 7: How You'll Use It Every Day
Once deployed, append this one-liner to any long task:

```bash
# Example: Run a long script, backup, or training job
python long_job.py && STATUS="SUCCESS" || STATUS="FAILURE"

# Instant ping to your phone:
curl -X POST https://notify.yourdomain.com/notify \
  -H "Authorization: Bearer my-super-secret-key-123" \
  -H "Content-Type: application/json" \
  -d '{"message": "Job finished with status: '"$STATUS"'", "status": "'"$STATUS"'"}'
```
