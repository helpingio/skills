---
name: "helpingio"
description: "Call the helping.io API (Open Responses compatible, at https://api.helping.io/v1): create responses, stream, handle tools and errors"
---

# helping.io API

helping.io is an Open Responses compatible API. It works with the official
OpenAI SDKs and other OpenAI-style clients, without a custom integration.

## Authenticate

Send an API key as a bearer token on every request:

```http
Authorization: Bearer sk_...
```

Keys start with `sk_` and are created in the app at app.helping.io, not
through the API. Keep one in `HELPINGIO_API_KEY` and send it only from a
server you operate. A missing, malformed, revoked, or unknown key is
a `401` with code `invalid_api_key`.

## Base URL

```text
https://api.helping.io/v1
```

Point the SDK's base URL at the `/v1` prefix, not at the host on its own.

## Routes

- `POST /v1/conversations`
- `DELETE /v1/conversations/{conversation_id}`
- `GET /v1/conversations/{conversation_id}`
- `POST /v1/conversations/{conversation_id}`
- `GET /v1/conversations/{conversation_id}/items`
- `POST /v1/conversations/{conversation_id}/items`
- `DELETE /v1/conversations/{conversation_id}/items/{item_id}`
- `GET /v1/conversations/{conversation_id}/items/{item_id}`
- `GET /v1/models`
- `POST /v1/responses`
- `DELETE /v1/responses/{response_id}`
- `GET /v1/responses/{response_id}`
- `POST /v1/responses/{response_id}/cancel`

Every other path under `/v1` answers `404` in the standard error envelope,
including `/v1/chat/completions`, which is not supported.

## Create a response

Each request carries one user turn. To continue, send the previous response's
id as `previous_response_id` and send only the new turn: the API keeps the
history, so it is never resent.

```json
{
  "model": "anthropic/claude-sonnet-5",
  "input": "Reply with exactly: pong"
}
```

`GET /v1/models` lists selectable models as `provider/model` ids. A model
policy may still refuse one, so a listed model is not a guarantee.

## Extensions

Fields beyond the Open Responses specification carry the `helpingio:`
prefix. The public extension fields:

- `helpingio:error`
- `helpingio:memory`
- `helpingio:pricing`
- `helpingio:schema_source`
- `helpingio:tool_calls_dropped`
- `helpingio:unreadable`
- `helpingio:usage`
- `helpingio:warnings`

Ignore any `helpingio:` field you do not recognize. Unknown request fields
never fail a request.

## Streaming

Set `"stream": true` for server-sent events. The sequence is ordered and ends
in exactly one terminal event.

A quiet stream sends a comment frame every 15 seconds. A stream stays open for
at most 300 seconds, then closes with its terminal event. See
`references/events.md` for every event name.

A non-streaming request waits at most 90 seconds, then returns the
response object as it stands, in progress. Retrieve it by id to read the
finished one.

## Tools

Declare function tools in the request, receive `function_call` items in the
output, run them, and post the results back as `function_call_output` items
on the next request. The standard SDK tool loop works unchanged.

## Errors and retries

Every failure is one envelope: an HTTP status, a `type`, and a `code`. Read
the `code`, never the message text.

Honor `Retry-After` whenever a response carries it, and wait the seconds it
names. These codes answer with it:

- `rate_limit_exceeded`
- `stream_limit_exceeded`
- `auth_unavailable`
- `database_unavailable`
- `gateway_overloaded`

When a `429` or a `5xx` arrives without the header, back off exponentially
with jitter. Any other `4xx` is a decision, not a delay: fix the request, the
key, or the entitlement.

Send an `Idempotency-Key` on every create, so a retry cannot produce a second
response and a second charge. Keys are printable ASCII, spaces included, and at
most 255 bytes; a longer key, or one with other characters, is a `400`. A retry
with the same key and body returns the first response, tool-output requests
included. Reusing a key with a different body is a `409`
`idempotency_conflict`, and a retry while the first request is still being
processed is a `409` `idempotency_in_progress`.

See `references/errors.md` for every code and what each one means.

## Which reference to read

- `references/errors.md` when handling a non-2xx status or a failed response.
- `references/events.md` when consuming a stream.
- `references/constants.md` for the timing and size limits above.
- `references/glossary.md` for what a platform noun means.
- `references/examples.md` for captured requests and responses to build a
  body against.
- `references/openapi.json` for the exact request and response shape of a
  route, or to generate a client. It is the whole `/v1` contract as OpenAPI
  3.1, the same document the reference pages are rendered from.
- `scripts/smoke.sh` to check a key and reach the API once.

The full documentation is at https://docs.helping.io. The whole site as one file is
https://docs.helping.io/llms-full.txt, and https://docs.helping.io/llms-small.txt is the abridged
export for a smaller context window.
