# Glossary

The name helping.io uses for each thing, and what it means. These are the
names that appear in the documentation and on the wire.

- **organization**: The account that owns API keys and billing. Every request runs on behalf of one organization.
- **passkey**: A second sign-in step that uses your device's screen lock or a security key instead of a code. Resists phishing.
- **recovery codes**: One-time codes that complete a sign-in when your passkey is not available. Shown once; generating a new set cancels the old one.
- **API key**: A secret that starts with sk_ and identifies your organization to the API. Shown once when created; rotate the key if it is lost.
- **credits**: Prepaid balance that requests are billed against at the real cost of the model calls they make.
- **plan**: What an organization pays each month to use helping.io. Requests also need credits, which are bought separately from the plan.
- **Model**: A language model you can select, named provider/model, for example anthropic/claude-sonnet-5.
- **provider**: The company whose model serves a request; the first half of a model id.
- **Tools your API calls declare**: Function tools sent in a request's tools array, executed by your code when the model calls them.
- **Reasoning**: How much thinking a model does before answering; the available settings depend on the model.
- **Max output tokens**: The most tokens a single turn may produce.
- **JSON Schema**: The standard for describing the shape of JSON data; used for input and output shapes and for structured output. Always written as the two words.
- **spend budget**: An allowance in credits set for one scope (your organization, a member, or an API key); a request that would exceed it is refused with scope_budget_exceeded.
- **response**: The object POST /v1/responses creates and GET /v1/responses/{id} returns: the model's output, its status, and usage.
- **Responses API**: The OpenAI Responses API wire format, which the Open Responses specification follows and helping.io's /v1 implements.
- **Conversation**: The history the server keeps for a series of responses. Created for you by a plain call, or explicitly, and named on a response by its id.
- **Rotate**: Replace a key's secret with a new one; the old secret stops working, at once or after a grace period of up to 7 days.
- **Revoke**: Disable a key immediately without deleting its record.
- **helpingio:unreadable**: List field naming the items on a page that are stored but could not be read. The other items are returned as usual.
- **helpingio:schema_source**: Error field: on a response that failed output_schema_mismatch, the schema the reply was checked against: text.format for the request's own, declared for the output the workflow declares.
- **helpingio:tool_calls_dropped**: Response field: on a response that runs under a max_tool_calls (sent with the request that started the turn), how many tool calls were cut, which were neither returned nor run. Absent when nothing was cut.
- **helpingio:usage**: Error field: on the 502 a non-streaming request answers when the model provider failed partway through its reply, the usage that reply was billed, in the shape of a response's usage. Absent when nothing was billed.
- **helpingio:warnings**: Response field: a list of the request fields the response accepted and did not apply (type unsupported) or applied in place of another (type compatibility), each with its param and a message. Absent when there is nothing to report.
- **item_unreadable**: Error code for an item that is stored but could not be read.
- **end_user_blocked**: Error code for a response the model provider refused because it refuses requests for the end user named by the request's safety_identifier or user.
- **output_schema_mismatch**: Error code for a response whose reply did not match the JSON schema the request set in text.format.
- **Default rate limit**: The request rate limit an organization has unless a different one is set for it. The rate-limit headers carry the live values.
