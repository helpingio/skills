# helping.io

This project calls the helping.io API.

- **Wire format.** Open Responses compatible. Use an official OpenAI SDK, an
  OpenAI-style client or any Open Responses client; no custom integration is
  needed.
- **Base URL.** `https://api.helping.io/v1`. Point the SDK at the `/v1` prefix, not at
  the host.
- **Auth.** `Authorization: Bearer sk_...`, from `HELPINGIO_API_KEY`.
  Server side only; never ship a key to a client.
- **One turn per request.** Send the new turn and `previous_response_id`.
  The API keeps the history: do not resend it.
- **Extensions.** `helpingio:error` and `helpingio:memory` and `helpingio:pricing` and `helpingio:schema_source` and `helpingio:tool_calls_dropped` and `helpingio:unreadable` and `helpingio:usage` and `helpingio:warnings` are the
  helping.io fields on the wire. Ignore any `helpingio:` field you do not
  recognize.
- **Errors.** Branch on `code`, never on the message. Honor `Retry-After`
  when it is there; on a `429` or a `5xx` without it, back off exponentially
  with jitter. Any other `4xx` is a decision, not a delay.
- **Idempotency.** Send an `Idempotency-Key` on every create: printable
  ASCII, at most 255 bytes. The same key and body returns the first
  response; a different body is a `409` `idempotency_conflict`.
- **Docs.** https://docs.helping.io. The whole site as one file is
  https://docs.helping.io/llms-full.txt; https://docs.helping.io/llms-small.txt is the abridged
  export.
