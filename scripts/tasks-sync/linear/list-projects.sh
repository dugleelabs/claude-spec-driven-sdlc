#!/usr/bin/env bash
# Lists projects accessible to a team.
# Usage: ./list-projects.sh <team-id>
# Output: JSON array of { id, name, state }

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: list-projects.sh <team-id>" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_graphql.sh"

variables=$(jq -n --arg id "$1" '{id: $id}')
response=$(_linear_graphql '
  query($id: String!) {
    team(id: $id) {
      projects {
        nodes { id name state }
      }
    }
  }
' "$variables")

echo "$response" | jq '[.data.team.projects.nodes[] | {id, name, state}]'
