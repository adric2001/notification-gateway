#!/usr/bin/env bash
# ==============================================================================
# Local Development Runner Guide (scripts/local_run.sh)
# ==============================================================================
# This script lets you run and test your Telegram gateway locally on your machine
# before deploying it to Kubernetes.
#
# Steps to write this script:
#
# 1. Enable strict error handling:
#    set -euo pipefail
#
# 2. Check for local .env file:
#    if [ ! -f .env ]; then
#        echo "Error: .env file not found. Copy .env.example and set your Telegram tokens!"
#        exit 1
#    fi
#
# 3. Create or activate a Python virtual environment:
#    if [ ! -d ".venv" ]; then
#        echo "Creating virtual environment..."
#        python3 -m venv .venv
#    fi
#    source .venv/bin/activate
#
# 4. Install dependencies:
#    pip install -r app/requirements.txt -r app/requirements-dev.txt
#
# 5. Start the FastAPI ASGI server with auto-reload:
#    echo "Starting Telegram Notification Gateway on http://localhost:8000"
#    uvicorn app.src.main:app --reload --port 8000
