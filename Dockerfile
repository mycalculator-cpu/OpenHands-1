FROM ghcr.io/all-hands-ai/openhands:0.54.0

# Set Pollinations AI environment variables
ENV LLM_MODEL=qwen-coder
ENV LLM_BASE_URL=https://text.pollinations.ai/openai
ENV LLM_API_KEY=""
ENV LLM_PROVIDER=openai
ENV LLM_NATIVE_TOOL_CALLING=true
ENV LLM_INPUT_COST_PER_TOKEN=0.0
ENV LLM_OUTPUT_COST_PER_TOKEN=0.0
ENV OPENHANDS_FREE_MODE=true

# Expose the port
EXPOSE 3000

# Use the original OpenHands entrypoint
CMD ["python", "/app/openhands/server/listen.py"]
