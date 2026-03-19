# ---------- Builder Stage ----------
FROM python:3.11-slim AS builder

WORKDIR /install

COPY app/requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# ---------- Runtime Stage ----------
FROM python:3.11-slim

WORKDIR /app

# Create non-root user
RUN useradd -m appuser

# Copy installed dependencies
COPY --from=builder /install /usr/local

# Copy application code
COPY app/ .

# Change ownership
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl --fail http://localhost:5000/health || exit 1

CMD ["python", "app.py"]
