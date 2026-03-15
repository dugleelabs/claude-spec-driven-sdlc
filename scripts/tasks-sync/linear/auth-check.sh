#!/usr/bin/env bash
# Validates the Linear API key by querying the authenticated user.
# Usage: ./auth-check.sh
# Output: JSON { id, name }
# Exit 1 if: LINEAR_API_KEY not set or invalid

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_graphql.sh"

response=$(_linear_graphql '{ viewer { id name } }')

# Extract viewer data
echo "$response" | jq '{id: .data.viewer.id, name: .data.viewer.name}'
