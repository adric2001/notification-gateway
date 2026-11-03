# notification-gateway
Personal Webhook Notification Gateway ("Personal Pager")


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
│   │       ├── telegram.py         # Async Telegram delivery logic
│   │       └── discord.py          # Async Discord webhook delivery logic
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
