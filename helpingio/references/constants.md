# Limits and timings

The fixed values of the `/v1` surface. Rate limits are not here: they vary by
organization and arrive on every allowed response in the
`x-ratelimit-*` headers.

| Name | Value | What |
| --- | --- | --- |
| `context_overhead_tokens` | 2000 tokens | Tokens reserved for the platform's own instructions when a turn is checked against the context window. |
| `context_safety_margin_pct` | 15 percent | The share of the context window, after the reply's max_output_tokens, held back because a turn's size is estimated rather than counted. |
| `delete_burst` | 100 requests | How many delete and cancel requests one organization may make at once, across responses, conversations and items. |
| `delete_per_second` | 2 requests per second | The sustained rate of delete and cancel requests once the burst is spent. |
| `idempotency_key_max_len` | 255 bytes | The longest an Idempotency-Key header value may be. |
| `idempotency_window_hours` | 24 hours | How long an Idempotency-Key is remembered. After it, the key may be used again for a new request. |
| `keepalive_interval_secs` | 15 seconds | How often a stream sends a keep-alive comment while there is nothing else to send. |
| `max_output_tokens_min` | 16 tokens | The smallest value max_output_tokens accepts. |
| `metadata_max_key_chars` | 64 characters | The longest a metadata key may be. |
| `metadata_max_pairs` | 16 pairs | The most key-value pairs metadata may carry. |
| `metadata_max_value_chars` | 512 characters | The longest a metadata value may be. |
| `retrieve_burst` | 300 requests | How many requests to retrieve a response or to use the Conversations API, deletes aside, one organization may make at once. |
| `retrieve_per_second` | 5 requests per second | The sustained rate of those requests once the burst is spent. |
| `safety_identifier_max_chars` | 64 characters | The longest a safety_identifier may be. |
| `stream_deadline_secs` | 300 seconds | The longest a single streamed response stays open. |
| `sync_timeout_secs` | 90 seconds | How long a non-streaming request waits for a result before it returns the response in progress for you to retrieve later. |
| `truncation_headroom_pct` | 10 percent | How much of the usable budget truncation auto frees beyond what the turn needs, so the next few turns fit without dropping more. |
