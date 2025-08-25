# Use the existing OpenHands build
FROM node:24.3.0-bookworm-slim AS frontend-builder
WORKDIR /app
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci
COPY frontend ./
RUN npm run build

FROM python:3.12.10-slim AS base
WORKDIR /app
ENV PYTHONPATH='/app'
COPY backend/pyproject.toml backend/poetry.lock ./
RUN pip install poetry && poetry install --no-dev
COPY backend ./
COPY --from=frontend-builder /app/dist ./frontend/dist

# Add Pollinations AI environment variables
ENV LLM_MODEL=qwen-coder
ENV LLM_BASE_URL=https://text.pollinations.ai/openai
ENV LLM_API_KEY=""
ENV LLM_NATIVE_TOOL_CALLING=true

EXPOSE 3000
CMD ["python", "openhands/server/listen.py"]
