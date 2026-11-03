"""
Notification Tests (app/tests/test_notify.py)
==============================================
This file tests the /notify endpoint and authentication.

Key Testing Concepts to Learn:
1. Mocking: When testing your application, you NEVER want your test suite to make
   real network requests to Telegram. You "mock" or patch the Telegram function so
   it returns a fake success response instantly.
2. Auth Testing: Verify that requests without a Bearer token or with a bad token
   receive a 401 Unauthorized status.
3. Payload Validation: Verify that invalid JSON (e.g. missing 'message') returns 422 Unprocessable Entity.
"""

import pytest
from unittest.mock import AsyncMock, patch
from fastapi.testclient import TestClient

# TODO: Import your app instance when ready:
# from src.main import app

# client = TestClient(app)


def test_notify_unauthorized_without_token():
    """
    Test that sending a request without the Authorization header returns 401/403.

    Steps to implement when practicing:
    1. Send a POST request without auth headers:
       response = client.post("/notify", json={"message": "hello"})
    2. Assert that the status is 401 or 403:
       assert response.status_code in (401, 403)
    """
    # TODO: Write test logic here
    pass


def test_notify_with_valid_token_and_mocked_telegram():
    """
    Test that sending a valid token and message successfully returns 200 OK.

    Steps to implement when practicing:
    1. Patch the send_telegram_message function so it doesn't call the real API:
       with patch("src.main.send_telegram_message", new_callable=AsyncMock) as mock_send:
           mock_send.return_value = True
           response = client.post(
               "/notify",
               headers={"Authorization": "Bearer test-secret-key"},
               json={"message": "Backup complete!", "status": "success"}
           )
           assert response.status_code == 200
           assert response.json()["ok"] is True
    """
    # TODO: Write test logic here
    pass
