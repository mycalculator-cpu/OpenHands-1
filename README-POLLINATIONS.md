# 🚀 OpenHands + Pollinations AI

This is a modified version of OpenHands that uses **Pollinations AI** instead of paid LLM providers. Get unlimited AI assistance completely free!

## ✨ What's Changed

- ✅ **Pollinations AI Integration** - Advanced GPT-4 level model
- ✅ **Unlimited Usage** - No API keys, no billing limits
- ✅ **Same OpenHands Interface** - All original features intact
- ✅ **One-Click Setup** - Easy Codespace deployment

## 🚀 Quick Start (Codespaces)

### Option 1: One-Click Deploy

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/mycalculator-cpu/OpenHands-1)

### Option 2: Manual Setup

1. **Fork this repository** to your GitHub account
2. **Open in Codespaces** - Click the green "Code" button → "Codespaces" → "Create codespace"
3. **Wait for setup** - The container will automatically install everything
4. **Start OpenHands** - Run: `make run`
5. **Open the URL** - Codespaces will show you the link

## 🎯 Features

### Original OpenHands Features
- ✅ **AI Agent** - Autonomous coding assistant
- ✅ **Code Generation** - Write complete applications
- ✅ **Bug Fixing** - Debug and fix issues
- ✅ **File Management** - Create, edit, organize files
- ✅ **Terminal Access** - Full command line interface
- ✅ **Web Interface** - Modern, responsive UI

### New Pollinations AI Features
- 🆓 **Completely Free** - No API keys or billing
- 🚀 **Unlimited Usage** - No rate limits or quotas
- 🧠 **Advanced Model** - GPT-4 level performance
- ⚡ **Fast Responses** - Optimized for speed
- 🔒 **Privacy Focused** - No data collection

## 🛠️ Local Development

### Prerequisites
- Python 3.12+
- Node.js 18+
- Poetry

### Setup
```bash
# Clone the repository
git clone https://github.com/mycalculator-cpu/OpenHands-1.git
cd OpenHands-1

# Install dependencies
poetry install
cd frontend && npm install && npm run build && cd ..

# Set environment variables
export LLM_MODEL="pollinations-gpt4"
export LLM_API_KEY="not-needed"
export LLM_BASE_URL="https://text.pollinations.ai"

# Start OpenHands
make run
```

## 🔧 Configuration

The Pollinations AI provider is automatically configured with these settings:

```bash
LLM_MODEL="pollinations-gpt4"
LLM_API_KEY="not-needed"
LLM_BASE_URL="https://text.pollinations.ai"
POLLINATIONS_ENABLED="true"
```

## 📝 Usage Examples

### Basic Chat
```
User: "Create a Python web scraper for news articles"
AI: I'll help you create a comprehensive web scraper...
```

### Code Generation
```
User: "Build a REST API with FastAPI for a todo app"
AI: I'll create a complete FastAPI todo application...
```

### Debugging
```
User: "Fix this error: ModuleNotFoundError: No module named 'requests'"
AI: This error occurs because the requests module isn't installed...
```

## 🆚 Comparison with Original OpenHands

| Feature | Original OpenHands | OpenHands + Pollinations |
|---------|-------------------|--------------------------|
| **Cost** | $20+ per month | Completely Free |
| **Setup** | Complex API keys | One-click deploy |
| **Limits** | Usage quotas | Unlimited |
| **Model** | Various paid models | Advanced GPT-4 level |
| **Interface** | Same | Same |
| **Features** | All features | All features + more |

## 🔍 Technical Details

### Pollinations AI Provider
- **File**: `openhands/llm/pollinations.py`
- **Model**: Advanced GPT-4 compatible
- **API**: RESTful HTTP interface
- **Fallback**: Multiple endpoint support
- **Error Handling**: Robust retry logic

### Integration Points
- **LLM Registry**: Automatic provider selection
- **Configuration**: Environment-based setup
- **Codespace**: Pre-configured container
- **Dependencies**: Minimal additional requirements

## 🐛 Troubleshooting

### Common Issues

**Issue**: "No module named 'pollinations'"
```bash
# Solution: Install httpx dependency
pip install httpx
```

**Issue**: "LLM not responding"
```bash
# Solution: Check environment variables
echo $LLM_MODEL
echo $LLM_BASE_URL
```

**Issue**: "Frontend not loading"
```bash
# Solution: Build frontend
cd frontend && npm run build
```

### Getting Help

1. **Check Logs** - Look at the console output
2. **Verify Setup** - Ensure all environment variables are set
3. **Restart Service** - Try `make run` again
4. **Check Network** - Ensure internet connectivity

## 🤝 Contributing

Want to improve OpenHands + Pollinations AI?

1. **Fork** this repository
2. **Create** a feature branch
3. **Make** your changes
4. **Test** thoroughly
5. **Submit** a pull request

## 📄 License

This project maintains the same license as the original OpenHands project.

## 🙏 Credits

- **OpenHands Team** - Original amazing project
- **Pollinations AI** - Free AI model provider
- **Community** - Feedback and contributions

## 🔗 Links

- **Original OpenHands**: https://github.com/All-Hands-AI/OpenHands
- **Pollinations AI**: https://pollinations.ai
- **Documentation**: https://docs.all-hands.dev

---

**Ready to code with unlimited AI assistance? Click the Codespace button above!** 🚀