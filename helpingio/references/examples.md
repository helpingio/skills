# Worked examples

Captured output from the `/v1` surface, named `<band>/<name>`. Every body
here came back from this API rather than being written to illustrate it, which
is what makes one worth copying from.

Not every shape the surface produces has a capture, and the set grows as more
of them become capturable. A shape missing here is documented at https://docs.helping.io
with a body that was written rather than captured, and saying which is which is
the reason this file holds only the captured ones.

Three things to know before copying one:

- **An example without a request is a response published on its own.** The
  request is there only where it can be stated exactly, so nothing pairs a body
  with a response it did not produce.
- **`st/stream-order` publishes a sequence, not a body.** Its response block
  is the list of event names a streamed response emits, in the order they
  arrive.
- **Ids, timestamps and token counts are stable sample values** of the right
  shape. `model` names a model from the catalog; `GET /v1/models` lists
  every one you can use.

Every request also carries `Authorization: Bearer sk_...`, which is not
repeated below.

## `resp/first-turn`

### Request

```http
POST /v1/responses
```

```json
{
  "input": [
    {
      "content": "Say hello in exactly 3 words.",
      "role": "user",
      "type": "message"
    }
  ],
  "model": "anthropic/claude-sonnet-5"
}
```

### Response

```json
{
  "background": false,
  "completed_at": 1767225600,
  "conversation": null,
  "created_at": 1767225600,
  "error": null,
  "frequency_penalty": 0.0,
  "id": "resp_ZXhhbXBsZS9yZXNwL2ZpcnN0LXR1cm4AAAAAAAAAAAAAAAAAAAAAAA",
  "incomplete_details": null,
  "instructions": null,
  "max_output_tokens": null,
  "max_tool_calls": null,
  "metadata": null,
  "model": "anthropic/claude-sonnet-5",
  "object": "response",
  "output": [
    {
      "content": [
        {
          "annotations": [],
          "logprobs": [],
          "text": "Hello there, friend.",
          "type": "output_text"
        }
      ],
      "id": "msg_00000000000000000000000000000001",
      "role": "assistant",
      "status": "completed",
      "type": "message"
    }
  ],
  "parallel_tool_calls": true,
  "presence_penalty": 0.0,
  "previous_response_id": null,
  "prompt_cache_key": null,
  "reasoning": null,
  "safety_identifier": null,
  "service_tier": "default",
  "status": "completed",
  "store": true,
  "temperature": 1.0,
  "text": {
    "format": {
      "type": "text"
    }
  },
  "tool_choice": "auto",
  "tools": [],
  "top_logprobs": 0,
  "top_p": 1.0,
  "truncation": "disabled",
  "usage": {
    "input_tokens": 100,
    "input_tokens_details": {
      "cache_write_tokens": 0,
      "cached_tokens": 0
    },
    "output_tokens": 20,
    "output_tokens_details": {
      "reasoning_tokens": 0
    },
    "total_tokens": 120
  }
}
```

## `resp/continuation`

### Request

```http
POST /v1/responses
```

```json
{
  "input": "And again.",
  "previous_response_id": "resp_ZXhhbXBsZS9yZXNwL2ZpcnN0LXR1cm4AAAAAAAAAAAAAAAAAAAAAAA"
}
```

### Response

```json
{
  "background": false,
  "completed_at": 1767225600,
  "conversation": null,
  "created_at": 1767225600,
  "error": null,
  "frequency_penalty": 0.0,
  "id": "resp_ZXhhbXBsZS9yZXNwL2NvbnRpbnVhdGlvbgAAAAAAAAAAAAAAAAAAAA",
  "incomplete_details": null,
  "instructions": null,
  "max_output_tokens": null,
  "max_tool_calls": null,
  "metadata": null,
  "model": "anthropic/claude-sonnet-5",
  "object": "response",
  "output": [
    {
      "content": [
        {
          "annotations": [],
          "logprobs": [],
          "text": "Hello there, friend.",
          "type": "output_text"
        }
      ],
      "id": "msg_00000000000000000000000000000001",
      "role": "assistant",
      "status": "completed",
      "type": "message"
    }
  ],
  "parallel_tool_calls": true,
  "presence_penalty": 0.0,
  "previous_response_id": "resp_ZXhhbXBsZS9yZXNwL2ZpcnN0LXR1cm4AAAAAAAAAAAAAAAAAAAAAAA",
  "prompt_cache_key": null,
  "reasoning": null,
  "safety_identifier": null,
  "service_tier": "default",
  "status": "completed",
  "store": true,
  "temperature": 1.0,
  "text": {
    "format": {
      "type": "text"
    }
  },
  "tool_choice": "auto",
  "tools": [],
  "top_logprobs": 0,
  "top_p": 1.0,
  "truncation": "disabled",
  "usage": {
    "input_tokens": 100,
    "input_tokens_details": {
      "cache_write_tokens": 0,
      "cached_tokens": 0
    },
    "output_tokens": 20,
    "output_tokens_details": {
      "reasoning_tokens": 0
    },
    "total_tokens": 120
  }
}
```

## `resp/in-progress-at-the-wait-boundary`

### Response

```json
{
  "background": false,
  "completed_at": null,
  "conversation": null,
  "created_at": 1767225600,
  "error": null,
  "frequency_penalty": 0.0,
  "id": "resp_ZXhhbXBsZS9yZXNwL2luLXByb2dyZXNzLWF0LXRoZS13YWl0LWJvdQ",
  "incomplete_details": null,
  "instructions": null,
  "max_output_tokens": 1024,
  "max_tool_calls": null,
  "metadata": null,
  "model": "anthropic/claude-sonnet-5",
  "object": "response",
  "output": [],
  "parallel_tool_calls": true,
  "presence_penalty": 0.0,
  "previous_response_id": null,
  "prompt_cache_key": null,
  "reasoning": null,
  "safety_identifier": null,
  "service_tier": "default",
  "status": "in_progress",
  "store": true,
  "temperature": 1.0,
  "text": {
    "format": {
      "type": "text"
    }
  },
  "tool_choice": "auto",
  "tools": [],
  "top_logprobs": 0,
  "top_p": 1.0,
  "truncation": "disabled"
}
```

## `resp/retrieve`

### Request

```http
GET /v1/responses/{response_id}
```

### Response

```json
{
  "background": false,
  "completed_at": 1767225600,
  "conversation": null,
  "created_at": 1767225600,
  "error": null,
  "frequency_penalty": 0.0,
  "id": "resp_ZXhhbXBsZS9yZXNwL3JldHJpZXZlAAAAAAAAAAAAAAAAAAAAAAAAAA",
  "incomplete_details": null,
  "instructions": null,
  "max_output_tokens": null,
  "max_tool_calls": null,
  "metadata": null,
  "model": "anthropic/claude-sonnet-5",
  "object": "response",
  "output": [
    {
      "content": [
        {
          "annotations": [],
          "logprobs": [],
          "text": "Stored for later.",
          "type": "output_text"
        }
      ],
      "id": "msg_00000000000000000000000000000001",
      "role": "assistant",
      "status": "completed",
      "type": "message"
    }
  ],
  "parallel_tool_calls": true,
  "presence_penalty": 0.0,
  "previous_response_id": null,
  "prompt_cache_key": null,
  "reasoning": null,
  "safety_identifier": null,
  "service_tier": "default",
  "status": "completed",
  "store": true,
  "temperature": 1.0,
  "text": {
    "format": {
      "type": "text"
    }
  },
  "tool_choice": "auto",
  "tools": [],
  "top_logprobs": 0,
  "top_p": 1.0,
  "truncation": "disabled",
  "usage": {
    "input_tokens": 100,
    "input_tokens_details": {
      "cache_write_tokens": 0,
      "cached_tokens": 0
    },
    "output_tokens": 20,
    "output_tokens_details": {
      "reasoning_tokens": 0
    },
    "total_tokens": 120
  }
}
```

## `resp/delete`

### Request

```http
DELETE /v1/responses/{response_id}
```

### Response

```json
{
  "deleted": true,
  "id": "resp_ZXhhbXBsZS9yZXNwL2RlbGV0ZQAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
  "object": "response.deleted"
}
```

## `md/models-list`

### Request

```http
GET /v1/models
```

### Response

```json
{
  "data": [
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "anthropic/claude-fable-5",
      "object": "model",
      "owned_by": "anthropic"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "anthropic/claude-fable-5-1",
      "object": "model",
      "owned_by": "anthropic"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "anthropic/claude-opus-4-8",
      "object": "model",
      "owned_by": "anthropic"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "anthropic/claude-opus-5-5",
      "object": "model",
      "owned_by": "anthropic"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "anthropic/claude-sonnet-5",
      "object": "model",
      "owned_by": "anthropic"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "anthropic/claude-sonnet-5-5",
      "object": "model",
      "owned_by": "anthropic"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "google/gemini-3.1-flash-lite",
      "object": "model",
      "owned_by": "google"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "google/gemini-3.5-flash",
      "object": "model",
      "owned_by": "google"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "google/gemini-3.5-flash-lite",
      "object": "model",
      "owned_by": "google"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "google/gemini-3.6-flash",
      "object": "model",
      "owned_by": "google"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "google/gemini-3.7-flash",
      "object": "model",
      "owned_by": "google"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "google/gemini-3.8-flash",
      "object": "model",
      "owned_by": "google"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "google/gemini-4-argon",
      "object": "model",
      "owned_by": "google"
    },
    {
      "created": 1767225600,
      "helpingio:pricing": {
        "current": {
          "cache_read_tokens": "3",
          "cache_write_5m_tokens": "3",
          "input_tokens": "3",
          "output_tokens": "3"
        },
        "scheduled": [],
        "tiers": [],
        "unit": "credits_per_million_tokens"
      },
      "id": "openai/gpt-5.4-mini",
      "object": "model",
      "owned_by": "openai"
    }
  ],
  "object": "list"
}
```

## `fc/tool-call`

### Request

```http
POST /v1/responses
```

```json
{
  "input": [
    {
      "content": "What's the weather like in San Francisco?",
      "role": "user",
      "type": "message"
    }
  ],
  "model": "anthropic/claude-sonnet-5",
  "tools": [
    {
      "description": "Get the current weather for a location",
      "name": "get_weather",
      "parameters": {
        "properties": {
          "location": {
            "description": "The city and state, e.g. San Francisco, CA",
            "type": "string"
          }
        },
        "required": [
          "location"
        ],
        "type": "object"
      },
      "type": "function"
    }
  ]
}
```

### Response

```json
{
  "background": false,
  "completed_at": 1767225600,
  "conversation": null,
  "created_at": 1767225600,
  "error": null,
  "frequency_penalty": 0.0,
  "id": "resp_ZXhhbXBsZS9mYy90b29sLWNhbGwAAAAAAAAAAAAAAAAAAAAAAAAAAA",
  "incomplete_details": null,
  "instructions": null,
  "max_output_tokens": null,
  "max_tool_calls": null,
  "metadata": null,
  "model": "anthropic/claude-sonnet-5",
  "object": "response",
  "output": [
    {
      "content": [
        {
          "annotations": [],
          "logprobs": [],
          "text": "calling the tool",
          "type": "output_text"
        }
      ],
      "id": "msg_00000000000000000000000000000001",
      "role": "assistant",
      "status": "completed",
      "type": "message"
    },
    {
      "arguments": "{\"location\":\"San Francisco, CA\"}",
      "call_id": "00000000-0000-4000-8000-000000000002",
      "id": "fc_00000000-0000-4000-8000-000000000002",
      "name": "get_weather",
      "status": "completed",
      "type": "function_call"
    }
  ],
  "parallel_tool_calls": true,
  "presence_penalty": 0.0,
  "previous_response_id": null,
  "prompt_cache_key": null,
  "reasoning": null,
  "safety_identifier": null,
  "service_tier": "default",
  "status": "completed",
  "store": true,
  "temperature": 1.0,
  "text": {
    "format": {
      "type": "text"
    }
  },
  "tool_choice": "auto",
  "tools": [
    {
      "description": "Get the current weather for a location",
      "name": "get_weather",
      "parameters": {
        "properties": {
          "location": {
            "description": "The city and state, e.g. San Francisco, CA",
            "type": "string"
          }
        },
        "required": [
          "location"
        ],
        "type": "object"
      },
      "strict": null,
      "type": "function"
    }
  ],
  "top_logprobs": 0,
  "top_p": 1.0,
  "truncation": "disabled",
  "usage": {
    "input_tokens": 100,
    "input_tokens_details": {
      "cache_write_tokens": 0,
      "cached_tokens": 0
    },
    "output_tokens": 20,
    "output_tokens_details": {
      "reasoning_tokens": 0
    },
    "total_tokens": 120
  }
}
```

## `fc/tool-output-continuation`

### Request

```http
POST /v1/responses
```

```json
{
  "input": [
    {
      "call_id": "00000000-0000-4000-8000-000000000002",
      "output": "{\"temperature\": \"64F\", \"conditions\": \"foggy\"}",
      "type": "function_call_output"
    }
  ],
  "model": "anthropic/claude-sonnet-5",
  "previous_response_id": "resp_ZXhhbXBsZS9mYy90b29sLWNhbGwAAAAAAAAAAAAAAAAAAAAAAAAAAA"
}
```

### Response

```json
{
  "background": false,
  "completed_at": 1767225600,
  "conversation": null,
  "created_at": 1767225600,
  "error": null,
  "frequency_penalty": 0.0,
  "id": "resp_ZXhhbXBsZS9mYy90b29sLW91dHB1dC1jb250aW51YXRpb24AAAAAAA",
  "incomplete_details": null,
  "instructions": null,
  "max_output_tokens": null,
  "max_tool_calls": null,
  "metadata": null,
  "model": "anthropic/claude-sonnet-5",
  "object": "response",
  "output": [
    {
      "content": [
        {
          "annotations": [],
          "logprobs": [],
          "text": "It is 64F and foggy in San Francisco.",
          "type": "output_text"
        }
      ],
      "id": "msg_00000000000000000000000000000001",
      "role": "assistant",
      "status": "completed",
      "type": "message"
    }
  ],
  "parallel_tool_calls": true,
  "presence_penalty": 0.0,
  "previous_response_id": "resp_ZXhhbXBsZS9mYy90b29sLWNhbGwAAAAAAAAAAAAAAAAAAAAAAAAAAA",
  "prompt_cache_key": null,
  "reasoning": null,
  "safety_identifier": null,
  "service_tier": "default",
  "status": "completed",
  "store": true,
  "temperature": 1.0,
  "text": {
    "format": {
      "type": "text"
    }
  },
  "tool_choice": "auto",
  "tools": [],
  "top_logprobs": 0,
  "top_p": 1.0,
  "truncation": "disabled",
  "usage": {
    "input_tokens": 200,
    "input_tokens_details": {
      "cache_write_tokens": 0,
      "cached_tokens": 0
    },
    "output_tokens": 40,
    "output_tokens_details": {
      "reasoning_tokens": 0
    },
    "total_tokens": 240
  }
}
```

## `st/stream-order`

### Request

```http
POST /v1/responses
```

```json
{
  "input": [
    {
      "content": "Count from 1 to 5.",
      "role": "user",
      "type": "message"
    }
  ],
  "model": "anthropic/claude-sonnet-5",
  "stream": true
}
```

### Response

```json
[
  "response.created",
  "response.in_progress",
  "response.output_item.added",
  "response.content_part.added",
  "response.output_text.delta",
  "response.output_text.done",
  "response.content_part.done",
  "response.output_item.done",
  "response.completed"
]
```

## `st/stream-terminal`

### Request

```http
POST /v1/responses
```

```json
{
  "input": [
    {
      "content": "Count from 1 to 5.",
      "role": "user",
      "type": "message"
    }
  ],
  "model": "anthropic/claude-sonnet-5",
  "stream": true
}
```

### Response

```json
{
  "response": {
    "background": false,
    "completed_at": 1767225600,
    "conversation": null,
    "created_at": 1767225600,
    "error": null,
    "frequency_penalty": 0.0,
    "id": "resp_ZXhhbXBsZS9zdC9zdHJlYW0tdGVybWluYWwAAAAAAAAAAAAAAAAAAA",
    "incomplete_details": null,
    "instructions": null,
    "max_output_tokens": null,
    "max_tool_calls": null,
    "metadata": null,
    "model": "anthropic/claude-sonnet-5",
    "object": "response",
    "output": [
      {
        "content": [
          {
            "annotations": [],
            "logprobs": [],
            "text": "Streaming hello.",
            "type": "output_text"
          }
        ],
        "id": "msg_00000000000000000000000000000001",
        "role": "assistant",
        "status": "completed",
        "type": "message"
      }
    ],
    "parallel_tool_calls": true,
    "presence_penalty": 0.0,
    "previous_response_id": null,
    "prompt_cache_key": null,
    "reasoning": null,
    "safety_identifier": null,
    "service_tier": "default",
    "status": "completed",
    "store": true,
    "temperature": 1.0,
    "text": {
      "format": {
        "type": "text"
      }
    },
    "tool_choice": "auto",
    "tools": [],
    "top_logprobs": 0,
    "top_p": 1.0,
    "truncation": "disabled",
    "usage": {
      "input_tokens": 100,
      "input_tokens_details": {
        "cache_write_tokens": 0,
        "cached_tokens": 0
      },
      "output_tokens": 20,
      "output_tokens_details": {
        "reasoning_tokens": 0
      },
      "total_tokens": 120
    }
  },
  "sequence_number": 8,
  "type": "response.completed"
}
```

## `er/unsupported-endpoint-404`

### Request

```http
POST /v1/chat/completions
```

```json
{
  "messages": [
    {
      "content": "Hello.",
      "role": "user"
    }
  ],
  "model": "anthropic/claude-sonnet-5"
}
```

### Response

```json
{
  "error": {
    "code": "resource_not_found",
    "message": "Unknown request URL: /v1/chat/completions. This surface serves /v1/responses, /v1/conversations and /v1/models (Open Responses). Chat Completions is not supported.",
    "param": null,
    "type": "not_found_error"
  }
}
```

## `er/provider-rate-limited-429`

### Response

```json
{
  "error": {
    "code": "provider_rate_limited",
    "message": "The upstream model provider rate limited this request; retry later.",
    "param": null,
    "type": "rate_limit_error"
  }
}
```
