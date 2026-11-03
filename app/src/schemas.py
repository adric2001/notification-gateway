"""
Data Schemas (app/src/schemas.py)
=================================
This file defines the structure of data coming in (requests) and going out (responses).

Why use Pydantic schemas?
- FastAPI uses them to validate incoming JSON automatically. If a request is missing
  a required field or sends the wrong data type, FastAPI returns a helpful 422 error.
- They automatically generate the interactive documentation at http://localhost:8000/docs.
"""

from typing import Optional
from pydantic import BaseModel, Field


class AlertRequest(BaseModel):
    """
    The incoming payload sent to /notify.
    Keep it as simple as possible: a message, an optional title, and an optional status flag.

    Example JSON:
    {
        "message": "Model training finished in 2h 15m!",
        "title": "ML Training Pipeline",
        "status": "success"
    }
    """
    message: str = Field(
        ...,
        description="The main text of the alert to send to your Telegram."
    )
    title: Optional[str] = Field(
        default=None,
        description="Optional title or subject for the alert."
    )
    status: Optional[str] = Field(
        default="info",
        description="Status flag: 'success', 'failure', 'warning', or 'info'."
    )


class AlertResponse(BaseModel):
    """
    The JSON response returned after sending the Telegram notification.
    """
    ok: bool = Field(default=True, description="True if Telegram accepted the message.")
    status: str = Field(default="delivered", description="Delivery status.")


class HealthResponse(BaseModel):
    """
    Simple response for the health check endpoint (/healthz).
    """
    status: str = Field(default="ok")
