#!/usr/bin/env bash
# ==============================================================================
# Sample Curl Notification Utility (scripts/send_test_alert.sh)
# ==============================================================================
# Use this script to test your gateway or append it to any long-running command!
#
# Usage:
#   ./send_test_alert.sh "Backup completed successfully!"
#   ./send_test_alert.sh "Training run crashed with OutOfMemoryError" failure
#
# Steps to write this script:
#
# 1. Configuration variables:
#    GATEWAY_URL="${GATEWAY_URL:-http://localhost:8000/notify}"
#    API_KEY="${API_KEY:-your-secret-key}"
#    MESSAGE="${1:-Test alert ping from terminal}"
#    STATUS="${2:-info}"
#
# 2. Dispatch curl POST request:
#    curl -s -X POST "$GATEWAY_URL" \
#      -H "Authorization: Bearer $API_KEY" \
#      -H "Content-Type: application/json" \
#      -d '{
#        "message": "'"$MESSAGE"'",
#        "status": "'"$STATUS"'"
#      }' | jq .
#
# 3. How to use this with ANY command in your daily workflow:
#    python train_model.py && ./send_test_alert.sh "Training Done!" success || ./send_test_alert.sh "Training Failed!" failure
