FROM ghcr.io/all-hands-ai/openhands:0.54.0

# Keep your existing env/config
ENV WORKSPACE_BASE=/tmp/workspace
ENV SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:0.54-nikolaik
ENV SANDBOX_USER_ID=1000

# LLM (Pollinations/OpenAI-compatible) config — unchanged
ENV LLM_MODEL=openai-reasoning
ENV LLM_BASE_URL=https://text.pollinations.ai/openai
ENV LLM_API_KEY=""
ENV LLM_PROVIDER=openai
ENV LLM_NATIVE_TOOL_CALLING=true
ENV LLM_INPUT_COST_PER_TOKEN=0.0
ENV LLM_OUTPUT_COST_PER_TOKEN=0.0

# Networking — unchanged
ENV PORT=3000
ENV HOST=0.0.0.0
ENV SERVE_FRONTEND=true
ENV PYTHONUNBUFFERED=1

# Optional default (you also set it in compose)
ENV SANDBOX_TYPE=local

# Workspace — unchanged
RUN mkdir -p /tmp/workspace
EXPOSE 3000

# Start the actual ASGI server (fixes immediate exit)
ENTRYPOINT ["python","-m","uvicorn","openhands.server.listen:app"]
CMD ["--host","0.0.0.0","--port","3000","--proxy-headers","--forwarded-allow-ips","*"]
