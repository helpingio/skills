# helping.io skills

The skill for calling the helping.io API, `https://api.helping.io/v1`:
authenticating, the routes, streaming, the tool loop, and which errors are worth
retrying, with every error code, stream event, limit and captured example behind
it.

The skill calls the helping.io API (https://api.helping.io/v1, or the address you set in
HELPINGIO_BASE_URL) with the key in HELPINGIO_API_KEY, and reads docs from
docs.helping.io. It collects nothing and sends nothing anywhere else.

## Claude Code

```text
/plugin marketplace add helpingio/skills
/plugin install helpingio@helpingio
```

Claude then reads the skill whenever a task calls the API. To load it by
hand, run `/helpingio`, or `/helpingio:helpingio` when
another command already uses that name.

## Other agents

`skills/helpingio/SKILL.md` is an Agent Skills file: copy the `skills/helpingio/`
directory into the skills directory your agent reads. This repository is also
a Cursor plugin and a Gemini CLI extension, with the same skill in each.

For an agent that reads a file at the root of your repository instead,
`AGENTS.md` is the same guidance in short form: copy it into your repository.
For Cursor, copy `cursor/helpingio.mdc` into `.cursor/rules/`.

## Documentation

https://docs.helping.io

Every file here is generated from the documentation's build, and the next
release replaces any change made to it here.

## License

MIT. See [LICENSE](LICENSE).
