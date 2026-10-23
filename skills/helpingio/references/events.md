# Stream events

Every event a streaming response can send, in the order a stream produces
them, with what each one means to a client reading the stream.

Exactly one event marked Terminal ends a stream, and nothing follows it. Treat
an unknown event name as informational and keep reading.

| Event | Terminal | When |
| --- | --- | --- |
| `response.created` |  | The response exists. The payload carries the response object with an empty `output` |
| `response.in_progress` |  | The response is producing output |
| `response.output_item.added` |  | An output item (message, function call, reasoning) opened |
| `response.content_part.added` |  | A content part inside a message opened |
| `response.output_text.delta` |  | A chunk of assistant text |
| `response.output_text.done` |  | The complete text of that part |
| `response.refusal.delta` |  | The model declined and gave an explanation, which streams as the text of a `refusal` content part after any text already produced. Not sent when there is no explanation |
| `response.refusal.done` |  | The refusal part is complete and carries its text, which is empty when there is no explanation. The response then completes with `response.completed` |
| `response.function_call_arguments.delta` |  | A chunk of a function call's JSON arguments |
| `response.function_call_arguments.done` |  | The complete arguments for that call |
| `response.reasoning_text.delta` |  | A chunk of reasoning content, when the model produces reasoning |
| `response.reasoning_text.done` |  | The complete reasoning content |
| `response.content_part.done` |  | A content part inside a message closed |
| `response.output_item.done` |  | An output item closed |
| `response.completed` | Yes | The payload is the full response object, including `usage` |
| `response.failed` | Yes | The response object carries `error.code` and `error.message` |
| `response.incomplete` | Yes | The response stopped early, for example at `max_output_tokens`. Read `incomplete_details.reason` |
| `error` | Yes | The final state was not known when the stream ended, with code `response_unresolved`. The response may still complete: retrieve it by id, or retry |

## Events that never arrive

The Open Responses schema declares these, and the API reference carries the
whole vocabulary, so a generated client can hold names this API never sends.
Do not wait for one of them.

| Event | What you get instead |
| --- | --- |
| `response.queued` | A stream opens with `response.created` and `response.in_progress`, so read `response.created` as the start |
| `response.output_text.annotation.added` | Output text is not annotated here, so `annotations` on a text part is always empty |
| `response.reasoning_summary_part.added` | Reasoning is not summarized. The reasoning item opens with `response.output_item.added` |
| `response.reasoning_summary_part.done` | Reasoning is not summarized. The reasoning item closes with `response.output_item.done` |
| `response.reasoning_summary_text.delta` | Reasoning is not summarized. The reasoning itself streams on `response.reasoning_text.delta` |
| `response.reasoning_summary_text.done` | Reasoning is not summarized. The complete reasoning arrives on `response.reasoning_text.done` |
