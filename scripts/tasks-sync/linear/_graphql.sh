#!/usr/bin/env bash
# Linear GraphQL helper — sourced by other Linear scripts, not called directly.
# Requires: LINEAR_API_KEY via environment variable or ~/.config/linear/credentials
# Also requires: curl, jq

set -euo pipefail

# Auto-load LINEAR_API_KEY from global credentials file if not already set
_linear_load_credentials() {
  if [[ -n "${LINEAR_API_KEY:-}" ]]; then
    return 0
  fi

  local cred_file="${HOME}/.config/linear/credentials"
  if [[ -f "$cred_file" ]]; then
    local key
    key=$(grep -E '^LINEAR_API_KEY=' "$cred_file" 2>/dev/null | head -1 | cut -d'=' -f2-)
    if [[ -n "$key" ]]; then
      export LINEAR_API_KEY="$key"
      return 0
    fi
  fi

  echo "Error: LINEAR_API_KEY not found." >&2
  echo "Set it via environment variable or create ~/.config/linear/credentials with:" >&2
  echo "  LINEAR_API_KEY=lin_api_xxxxx" >&2
  exit 1
}

_linear_graphql() {
  local query="$1"
  local variables="${2:-"{}"}"

  _linear_load_credentials

  # Compact variables to single line for safe passing to --argjson
  local compact_vars
  compact_vars=$(echo "$variables" | jq -c '.')

  local payload
  payload=$(jq -c -n --arg q "$query" --argjson v "$compact_vars" '{query: $q, variables: $v}')

  local response
  response=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: ${LINEAR_API_KEY}" \
    --data "$payload" \
    https://api.linear.app/graphql)

  # Check for GraphQL errors
  local errors
  errors=$(echo "$response" | jq -r '.errors // empty')
  if [[ -n "$errors" && "$errors" != "null" ]]; then
    echo "Linear API error: $(echo "$response" | jq -r '.errors[0].message // "Unknown error"')" >&2
    exit 1
  fi

  echo "$response"
}
