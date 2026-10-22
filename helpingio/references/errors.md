# Errors

Every public error code, generated from the API contract. Branch on
`code`, not on the message text, which is prose and may change.

A row with `Retry-After` set to Yes carries that response header when it
answers; wait the seconds it names and retry. A row set to No is a decision,
not a delay.

| Status | `code` | `type` | `Retry-After` | Meaning |
| --- | --- | --- | --- | --- |
| `400` | `context_length_exceeded` | `invalid_request_error` | No | The conversation plus this turn's input is larger than the model's context window; start a new conversation, send less, or set truncation to auto to let the oldest turns be dropped. |
| `400` | `invalid_input` | `invalid_request_error` | No | The request cannot be honored as written; the message names the field and the rule it broke. |
| `400` | `model_policy_violation` | `invalid_request_error` | No | Your organization's policy does not allow the model this request selected; the message names the model and the rule that refused it, and param is `model`. |
| `401` | `invalid_api_key` | `invalid_request_error` | No | The Authorization header is missing, malformed, or names a key that is not usable; check the key. |
| `402` | `payment_method_required` | `invalid_request_error` | No | The organization has no payment method on file, so no request can be served; add one in the billing settings. |
| `403` | `access_denied` | `permission_error` | No | The key is valid but is not entitled to what the request asked for; ask your administrator. |
| `404` | `resource_not_found` | `not_found_error` | No | The path or the previous response named by this request is not available to you. |
| `409` | `idempotency_conflict` | `invalid_request_error` | No | This Idempotency-Key was already used within the last 24 hours, and what it made cannot be returned for this request: the body differs, or this API key cannot read it. Nothing was created. |
| `409` | `idempotency_in_progress` | `invalid_request_error` | No | The first request with this Idempotency-Key is still being processed. Nothing was created; send the request again shortly. |
| `429` | `insufficient_credits` | `rate_limit_error` | No | The organization's credit balance is exhausted; top up in the billing settings. |
| `429` | `insufficient_quota` | `insufficient_quota` | No | The organization has no active plan, or no credit balance to pay for the request; the message says which. |
| `429` | `provider_rate_limited` | `rate_limit_error` | No | The model provider rate limited this request; retry, honoring Retry-After when one is present. |
| `429` | `rate_limit_exceeded` | `rate_limit_error` | Yes | This request exceeded a rate limit that applies to you; retry after the Retry-After header. |
| `429` | `scope_budget_exceeded` | `rate_limit_error` | No | A spend budget set for your organization, a member, or an API key is exhausted; the message states which. |
| `429` | `stream_limit_exceeded` | `rate_limit_error` | Yes | You are already holding the maximum number of open streams; nothing was started, so retry once one ends. |
| `500` | `database_error` | `api_error` | No | The request could not be completed; quote the x-request-id response header when reporting it. |
| `500` | `internal_server_error` | `api_error` | No | The request could not be completed; quote the x-request-id response header when reporting it. |
| `500` | `item_unreadable` | `api_error` | No | The item is stored but could not be read, so it cannot be returned. A list of items names it in helpingio:unreadable and returns the others. |
| `502` | `provider_overloaded` | `api_error` | No | The model provider reported that it is overloaded; retry shortly. |
| `502` | `provider_unavailable` | `api_error` | No | The model provider did not complete the request; retry shortly. |
| `503` | `auth_unavailable` | `overloaded_error` | Yes | Your credentials could not be checked this instant, which is not a verdict on the key; retry after the Retry-After header. |
| `503` | `database_unavailable` | `overloaded_error` | Yes | The request could not be served this instant and nothing was created; retry after the Retry-After header. |
| `503` | `gateway_overloaded` | `overloaded_error` | Yes | The API could not accept this request and nothing was created; retry after the Retry-After header, and retrying with the same Idempotency-Key still deduplicates. |
| `503` | `model_unavailable` | `overloaded_error` | No | The requested model cannot run right now and nothing was created; try again later or choose another model. |
| `504` | `request_timeout` | `api_error` | No | This request's wait window ended before a result was available and no response could be read back for it; quote the x-request-id response header when reporting it. |

## A response that fails after it starts

A failure raised once the response exists is not an HTTP error. It answers
`200` with a response object whose `status` is `"failed"` and whose
`error` carries a `code` and a `message`, and the same object arrives
inside a `response.failed` stream event.

The codes are a closed set. Branch on the ones you act on; a failure this
surface does not name separately arrives as `run_failed`.

| `code` | Meaning |
| --- | --- |
| `budget_exceeded` | The spending limit for a single response was reached. The message states what was spent against the limit, in credits. |
| `canceled` | The request was canceled before it finished. |
| `end_user_blocked` | The model provider refuses requests for the end user this request was sent for, named by its safety_identifier or user. Sending it again will not succeed for that end user. |
| `insufficient_credits` | The organization ran out of credits while the request was running. Add credits and send it again. The message states the balance, in credits. |
| `invalid_input` | An image or file in the conversation or the turn is not one the model accepts, by its type or its size. The request never reached the provider. |
| `model_unavailable` | The requested model could not run, and nothing was sent to a provider. Try again later or choose another model. |
| `org_daily_budget_exceeded` | The organization's daily spending limit was reached. The message states what was spent against the limit, in credits. |
| `output_schema_mismatch` | The model's reply did not match its JSON schema, so it was not returned. helpingio:schema_source names the schema: text.format for the request's own. |
| `provider_client_error` | The upstream model provider rejected the request. The request reached the provider and came back refused. |
| `provider_error` | The upstream model provider returned an unexpected error. |
| `provider_overloaded` | The upstream model provider is overloaded. Retry later. |
| `provider_rate_limited` | The upstream model provider rate limited the request. Retry later. |
| `provider_unavailable` | The upstream model provider failed to complete the request. Retry later. |
| `run_failed` | The request did not complete. Send it again, and contact support with the response id if it keeps failing. |
| `scope_budget_exceeded` | A spending limit set for this period was reached. The message states what was spent against the limit, in credits. |

## Errors during a stream

The HTTP status is already sent once a stream is open, so a failure that is not
carried by the response object arrives as an `error` event.

| `code` | `type` | Meaning |
| --- | --- | --- |
| `response_unresolved` | `server_error` | The stream ended before a result was ready. The response may still finish: retrieve it by the id response.created carried. Retrying without the same Idempotency-Key starts a second response. |
