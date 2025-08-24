#!/bin/bash

echo "🚀 Starting OpenHands + Pollinations AI..."
echo "✨ Unlimited free AI with advanced GPT-4 level model"
echo ""

# Set environment variables for Pollinations AI
export LLM_MODEL="pollinations-gpt4"
export LLM_API_KEY="not-needed"
export LLM_BASE_URL="https://text.pollinations.ai"
export POLLINATIONS_ENABLED="true"
export OPENHANDS_LOG_LEVEL="INFO"

echo "🔧 Environment configured:"
echo "   LLM_MODEL: $LLM_MODEL"
echo "   LLM_BASE_URL: $LLM_BASE_URL"
echo "   POLLINATIONS_ENABLED: $POLLINATIONS_ENABLED"
echo ""

# Check if dependencies are installed
echo "📦 Checking dependencies..."
if ! command -v poetry &> /dev/null; then
    echo "❌ Poetry not found. Installing..."
    curl -sSL https://install.python-poetry.org | python3 -
    export PATH="$HOME/.local/bin:$PATH"
fi

if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 18+"
    exit 1
fi

# Install Python dependencies
echo "📦 Installing Python dependencies..."
poetry install

# Install and build frontend
echo "🎨 Building frontend..."
cd frontend
npm install
npm run build
cd ..

echo ""
echo "🎯 Starting OpenHands with Pollinations AI..."
echo "🌐 The interface will be available at: http://localhost:3000"
echo "🆓 Enjoy unlimited free AI assistance!"
echo ""

# Start OpenHands
make run