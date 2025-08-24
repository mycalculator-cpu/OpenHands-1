"""Pollinations AI LLM provider for OpenHands."""

import time
from typing import Any, Dict, List, Optional, Iterator
import httpx
from litellm.types.utils import ModelResponse, Usage, Choices, Message
from openhands.core.config import LLMConfig
from openhands.core.logger import openhands_logger as logger
from openhands.llm.llm import LLM


class PollinationsLLM(LLM):
    """Pollinations AI LLM provider - Advanced model with unlimited usage."""
    
    def __init__(self, config: LLMConfig, service_id: str, **kwargs):
        super().__init__(config, service_id, **kwargs)
        self.client = httpx.Client(timeout=60.0)
        self.model = config.model or "pollinations-gpt4"
        logger.info(f"Initialized Pollinations AI LLM with model: {self.model}")
        
    def completion(self, messages: List[Dict[str, Any]], model: Optional[str] = None, **kwargs) -> ModelResponse:
        """Generate completion using Pollinations AI advanced model."""
        try:
            # Extract the latest user message for simple API
            prompt = ""
            for message in reversed(messages):
                if message.get("role") == "user":
                    prompt = message.get("content", "")
                    break
            
            if not prompt:
                raise ValueError("No user message found")
            
            logger.info(f"Generating completion for prompt: {prompt[:100]}...")
            
            # Try OpenAI compatible endpoint first (advanced model)
            try:
                response = self.client.post(
                    "https://text.pollinations.ai/openai",
                    json={
                        "model": "gpt-4",  # Use advanced model
                        "messages": messages,
                        "temperature": kwargs.get("temperature", 0.7),
                        "max_tokens": kwargs.get("max_tokens", 2000),
                        "stream": False
                    },
                    headers={"Content-Type": "application/json"}
                )
                
                if response.status_code == 200:
                    data = response.json()
                    if "choices" in data and len(data["choices"]) > 0:
                        content = data["choices"][0]["message"]["content"]
                        logger.info("Successfully generated response using OpenAI endpoint")
                        
                        return ModelResponse(
                            id=f"pollinations-{int(time.time())}",
                            choices=[
                                Choices(
                                    index=0,
                                    message=Message(role="assistant", content=content),
                                    finish_reason="stop"
                                )
                            ],
                            created=int(time.time()),
                            model="pollinations-gpt4",
                            object="chat.completion",
                            usage=Usage(
                                prompt_tokens=len(prompt.split()),
                                completion_tokens=len(content.split()),
                                total_tokens=len(prompt.split()) + len(content.split())
                            )
                        )
            except Exception as e:
                logger.warning(f"OpenAI endpoint failed, falling back to simple API: {e}")
            
            # Fallback to simple GET method
            encoded_prompt = httpx._utils.quote(prompt)
            response = self.client.get(f"https://text.pollinations.ai/{encoded_prompt}")
            response.raise_for_status()
            content = response.text.strip()
            
            if not content or content.lower() in ['undefined', 'null', '']:
                content = "I apologize, but I couldn't generate a proper response. Please try rephrasing your question."
            
            logger.info("Successfully generated response using simple API")
            
            return ModelResponse(
                id=f"pollinations-{int(time.time())}",
                choices=[
                    Choices(
                        index=0,
                        message=Message(role="assistant", content=content),
                        finish_reason="stop"
                    )
                ],
                created=int(time.time()),
                model="pollinations-gpt4",
                object="chat.completion",
                usage=Usage(
                    prompt_tokens=len(prompt.split()),
                    completion_tokens=len(content.split()),
                    total_tokens=len(prompt.split()) + len(content.split())
                )
            )
            
        except Exception as e:
            logger.error(f"Pollinations AI error: {e}")
            # Return error response in expected format
            return ModelResponse(
                id=f"pollinations-error-{int(time.time())}",
                choices=[
                    Choices(
                        index=0,
                        message=Message(role="assistant", content=f"I apologize, but I encountered an error: {str(e)}. Please try again."),
                        finish_reason="stop"
                    )
                ],
                created=int(time.time()),
                model="pollinations-gpt4",
                object="chat.completion",
                usage=Usage(prompt_tokens=0, completion_tokens=0, total_tokens=0)
            )
    
    def chat(self, messages: List[Dict[str, Any]], model: Optional[str] = None, **kwargs) -> ModelResponse:
        """Chat method - alias for completion."""
        return self.completion(messages, model, **kwargs)
    
    def stream_completion(self, messages: List[Dict[str, Any]], model: Optional[str] = None, **kwargs) -> Iterator[ModelResponse]:
        """Stream completion - for now, just return the full response."""
        response = self.completion(messages, model, **kwargs)
        yield response
    
    def get_model_info(self) -> Dict[str, Any]:
        """Get model information."""
        return {
            "model": "pollinations-gpt4",
            "provider": "pollinations",
            "description": "Advanced AI model with unlimited usage",
            "features": ["chat", "completion", "unlimited_usage"],
            "cost": "free"
        }