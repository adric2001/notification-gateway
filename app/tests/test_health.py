"""
Health Check Test (app/tests/test_health.py)
===========================================
This file tests the /healthz endpoint.

How API Testing Works with FastAPI:
- FastAPI includes a `TestClient` (built on top of `httpx`).
- You can simulate HTTP requests against your application without starting a real web server.
- Tests assert that the HTTP status code and response JSON match expectations.
"""

import pytest
from fastapi.testclient import TestClient

# TODO: Import your app instance when ready:
# from src.main import app

# client = TestClient(app)


def test_healthz_endpoint():
    """
    Test that GET /healthz returns status 200 and {"status": "ok"}.

    Steps to implement when practicing:
    1. Send a GET request:
       response = client.get("/healthz")
    2. Check the response status code:
       assert response.status_code == 200
    3. Check the response JSON payload:
       assert response.json() == {"status": "ok"}
    """
    # TODO: Write test logic here
    pass
