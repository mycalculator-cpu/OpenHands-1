#!/bin/bash

echo "🚀 Setting up OpenHands + Pollinations AI..."

# Mark the current repository as safe for Git to prevent "dubious ownership" errors,
# which can occur in containerized environments when directory ownership doesn't match the current user.
git config --global --add safe.directory "$(realpath .)"

# Install `nc`
sudo apt update && sudo apt install netcat -y

# Install additional dependencies for Pollinations AI
echo "📦 Installing Pollinations AI dependencies..."
pip install httpx

# Do common setup tasks
source .openhands/setup.sh

# Set up environment variables for Pollinations AI
echo "🔧 Configuring Pollinations AI..."
export LLM_MODEL="pollinations-gpt4"
export LLM_API_KEY="not-needed"
export LLM_BASE_URL="https://text.pollinations.ai"
export POLLINATIONS_ENABLED="true"

echo "✅ OpenHands + Pollinations AI setup complete!"
echo "🎯 Use 'make run' to start OpenHands with unlimited free AI!"
