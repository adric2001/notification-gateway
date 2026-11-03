"""
Telegram Notification Service (app/src/services/telegram.py)
============================================================
This file will contain the simple async function to send messages to Telegram.

How Telegram Bot Sending Works:
--------------------------------
1. Telegram provides a very simple HTTP API. To send a message, you make a POST request to:
   https://api.telegram.org/bot<YOUR_BOT_TOKEN>/sendMessage

2. The JSON body contains:
   {
       "chat_id": "<YOUR_CHAT_ID>",
       "text": "Your message here",
       "parse_mode": "HTML"   # (Optional: lets you use <b>bold</b>, <i>italic</i>, <code>code</code>)
   }

3. Using `httpx.AsyncClient`:
   Instead of standard `requests` (which pauses the whole Python program while waiting),
   `httpx.AsyncClient` is asynchronous (`await client.post(...)`), so your server remains fast.
"""

from typing import Optional
import httpx
from ..config import Settings
from ..schemas import AlertRequest


async def send_telegram_message(alert: AlertRequest, settings: Settings) -> bool:
    """
    Sends an alert message to your Telegram account using the Telegram Bot API.

    Steps to implement when practicing:
    1. Read the bot token and chat ID from `settings`:
       - token = settings.TELEGRAM_BOT_TOKEN.get_secret_value()
       - chat_id = settings.TELEGRAM_CHAT_ID
    2. Format the message text (e.g. add an emoji like ✅ for success or ❌ for failure).
    3. Build the URL:
       - url = f"https://api.telegram.org/bot{token}/sendMessage"
    4. Build the payload dictionary:
       - payload = {"chat_id": chat_id, "text": alert.message}
    5. Use httpx to send the request:
       - async with httpx.AsyncClient() as client:
             response = await client.post(url, json=payload, timeout=10.0)
             return response.status_code == 200
    """
    # TODO: Write your implementation here!
    pass
