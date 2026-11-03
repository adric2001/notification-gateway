# ==============================================================================
# Multi-Stage Production Dockerfile Guide (app/Dockerfile)
# ==============================================================================
# Multi-stage builds keep your final container image lean and secure:
# - Stage 1 (Builder): Downloads and compiles Python dependencies.
# - Stage 2 (Runner): Only includes the final compiled packages and app code.
#   Build tools (gcc, git, pip cache) are discarded, drastically reducing image size.
#
# Steps to write this Dockerfile:
#
# ------------------------------------------------------------------------------
# Stage 1: Dependency Builder
# ------------------------------------------------------------------------------
# 1. Base image for building:
#    FROM python:3.11-slim AS builder
#
# 2. Environment flags for Python inside containers:
#    ENV PYTHONDONTWRITEBYTECODE=1 \
#        PYTHONUNBUFFERED=1
#
# 3. Set a working directory:
#    WORKDIR /install
#
# 4. Copy requirements:
#    COPY requirements.txt .
#
# 5. Install packages into a separate prefix folder (/install):
#    RUN pip install --no-cache-dir --prefix=/install -r requirements.txt
#
# ------------------------------------------------------------------------------
# Stage 2: Minimal Production Runner
# ------------------------------------------------------------------------------
# 6. Fresh lean base image:
#    FROM python:3.11-slim AS runner
#
# 7. Set working directory:
#    WORKDIR /app
#
# 8. Create a non-root user (security best practice):
#    RUN useradd -u 10001 -s /sbin/nologin appuser
#
# 9. Copy installed dependencies from the builder stage:
#    COPY --from=builder /install /usr/local
#
# 10. Copy your application source code:
#     COPY ./src /app/src
#
# 11. Switch to the non-root user:
#     USER appuser
#
# 12. Expose the port:
#     EXPOSE 8000
#
# 13. Define the startup command:
#     CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
