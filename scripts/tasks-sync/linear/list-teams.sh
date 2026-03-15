#!/usr/bin/env bash
# Lists all teams in the Linear workspace.
# Usage: ./list-teams.sh
# Output: JSON array of { id, name, key }

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_graphql.sh"

response=$(_linear_graphql '{ teams { nodes { id name key } } }')

echo "$response" | jq '[.data.teams.nodes[] | {id, name, key}]'
