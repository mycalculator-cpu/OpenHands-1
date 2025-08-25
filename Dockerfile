FROM ghcr.io/all-hands-ai/openhands:0.54.0

# Set required OpenHands environment variables
ENV WORKSPACE_BASE=/tmp/workspace
ENV SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:0.54-nikolaik
ENV SANDBOX_USER_ID=1000

# Set Pollinations AI configuration
ENV LLM_MODEL=qwen-coder
ENV LLM_BASE_URL=https://text.pollinations.ai/openai
ENV LLM_API_KEY=""
ENV LLM_PROVIDER=openai
ENV LLM_NATIVE_TOOL_CALLING=true
ENV LLM_INPUT_COST_PER_TOKEN=0.0
ENV LLM_OUTPUT_COST_PER_TOKEN=0.0

# Fix port binding for Render.com
ENV PORT=3000
ENV HOST=0.0.0.0

# Create workspace directory
RUN mkdir -p /tmp/workspace

# Expose port 3000
EXPOSE 3000

# Start OpenHands server with correct binding
CMD ["python", "/app/openhands/server/listen.py", "--host", "0.0.0.0", "--port", "3000"]
