"""
Configuration Management (app/src/config.py)
=============================================
This file loads configuration settings from environment variables or a local .env file.

How it works:
- Pydantic's BaseSettings automatically looks for environment variables with the same names
  (e.g., API_SECRET_KEY, TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID).
- If they are set in your OS shell or in a `.env` file, Pydantic parses and validates them.
- SecretStr keeps sensitive tokens from accidentally being printed in logs.
"""

from functools import lru_cache
from pydantic import Field, SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """
    Application configuration for the Telegram Notification Gateway.
    """

    # --- App Info ---
    APP_NAME: str = Field(
        default="Telegram Notification Gateway",
        description="Name of the service."
    )

    # --- Security Token ---
    # The secret key you include in your curl command:
    # curl -H "Authorization: Bearer YOUR_API_SECRET_KEY" ...
    API_SECRET_KEY: SecretStr = Field(
        ...,  # '...' means this is required. The app won't start without it.
        description="A private secret key used to protect your webhook endpoint."
    )

    # --- Telegram Credentials ---
    # 1. TELEGRAM_BOT_TOKEN: Given by @BotFather when you create a bot (e.g., 123456789:ABCdef...).
    # 2. TELEGRAM_CHAT_ID: Your personal user ID or group ID (e.g., 987654321).
    TELEGRAM_BOT_TOKEN: SecretStr = Field(
        ...,
        description="Telegram bot token from @BotFather."
    )
    TELEGRAM_CHAT_ID: str = Field(
        ...,
        description="Your Telegram chat ID where alerts will be sent."
    )

    # Reads from a local .env file if running outside containers/k8s
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore"
    )


@lru_cache()
def get_settings() -> Settings:
    """
    Returns a cached Settings instance so it is only loaded once.
    FastAPI routes can use this via: settings: Settings = Depends(get_settings)
    """
    # TODO: When ready to practice, instantiate and return Settings()
    pass
