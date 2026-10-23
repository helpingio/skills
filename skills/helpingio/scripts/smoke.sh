#!/usr/bin/env bash
# Reach the helping.io API once: list the models, then create a response.
#
# Needs HELPINGIO_API_KEY in the environment. No key is stored in this file,
# and none should be added to it.
set -euo pipefail

: "${HELPINGIO_API_KEY:?set HELPINGIO_API_KEY to an sk_ key from app.helping.io}"

BASE_URL="${HELPINGIO_BASE_URL:-https://api.helping.io/v1}"
MODEL="${HELPINGIO_MODEL:-anthropic/claude-sonnet-5}"

echo "GET $BASE_URL/models"
curl --fail-with-body --silent --show-error \
  -H "Authorization: Bearer $HELPINGIO_API_KEY" \
  "$BASE_URL/models"
echo

echo "POST $BASE_URL/responses"
curl --fail-with-body --silent --show-error \
  -H "Authorization: Bearer $HELPINGIO_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"$MODEL\", \"input\": \"Reply with exactly: pong\"}" \
  "$BASE_URL/responses"
echo
