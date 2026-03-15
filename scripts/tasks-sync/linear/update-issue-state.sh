#!/usr/bin/env bash
# Updates an issue's workflow state.
# Usage: ./update-issue-state.sh <issue-id> <state-id>
# Output: JSON { id, identifier, state_name }

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: update-issue-state.sh <issue-id> <state-id>" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_graphql.sh"

variables=$(jq -n --arg id "$1" --arg stateId "$2" '{id: $id, stateId: $stateId}')

response=$(_linear_graphql '
  mutation($id: String!, $stateId: String!) {
    issueUpdate(id: $id, input: { stateId: $stateId }) {
      success
      issue { id identifier state { name } }
    }
  }
' "$variables")

success=$(echo "$response" | jq -r '.data.issueUpdate.success')
if [[ "$success" != "true" ]]; then
  echo "Error: Failed to update issue state" >&2
  exit 1
fi

echo "$response" | jq '{
  id: .data.issueUpdate.issue.id,
  identifier: .data.issueUpdate.issue.identifier,
  state_name: .data.issueUpdate.issue.state.name
}'
