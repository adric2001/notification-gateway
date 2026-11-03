"""
FastAPI Main Application (app/src/main.py)
===========================================
This is the entry point for your application. It sets up the web server routes.

Routes to learn and build:
1. GET /healthz  -> A simple health check used by Kubernetes or Docker to verify the app is alive.
2. POST /notify  -> The webhook endpoint where you send alerts with curl.
3. GET /metrics  -> Exposes Prometheus metrics so you can monitor server traffic.

Authentication:
- Uses a simple Bearer token check so random people on the internet cannot spam your Telegram.
"""

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from prometheus_fastapi_instrumentator import Instrumentator

from .config import Settings, get_settings
from .schemas import AlertRequest, AlertResponse, HealthResponse
from .services.telegram import send_telegram_message

# Create the FastAPI app instance
app = FastAPI(
    title="Telegram Notification Gateway",
    description="A simple microservice to receive webhooks and ping your Telegram.",
    version="1.0.0"
)

# Set up HTTP Bearer authentication helper
# In curl: -H "Authorization: Bearer YOUR_API_SECRET_KEY"
security = HTTPBearer()

# Optional: Add Prometheus metrics instrumentation
# Instrumentator().instrument(app).expose(app)


def verify_token(
    credentials: HTTPAuthorizationCredentials = Depends(security),
    settings: Settings = Depends(get_settings),
) -> str:
    """
    Dependency that checks if the Bearer token matches your API_SECRET_KEY.

    Steps to implement when practicing:
    1. Get the token from `credentials.credentials`.
    2. Compare it to `settings.API_SECRET_KEY.get_secret_value()`.
    3. If they don't match, raise HTTPException(status_code=401, detail="Invalid token").
    4. If they match, return the token.
    """
    # TODO: Write your token verification check here!
    pass


@app.get("/healthz", response_model=HealthResponse)
async def health_check():
    """
    Health check route for Docker and Kubernetes.
    Returns: {"status": "ok"}
    """
    # TODO: Return HealthResponse(status="ok")
    pass


@app.post("/notify", response_model=AlertResponse)
async def notify(
    alert: AlertRequest,
    token: str = Depends(verify_token),
    settings: Settings = Depends(get_settings),
):
    """
    Receives an alert payload and sends it to your Telegram.

    Steps to implement when practicing:
    1. Call: success = await send_telegram_message(alert, settings)
    2. If successful, return AlertResponse(ok=True, status="delivered")
    3. If failed, raise HTTPException(status_code=500, detail="Failed to deliver to Telegram")
    """
    # TODO: Write your notification handler here!
    pass
