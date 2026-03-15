#!/usr/bin/env bash
# Creates a sub-issue linked to a parent issue.
# Usage: ./create-sub-issue.sh <team-id> <project-id> <state-id> <parent-id> <title> [priority]
#   priority: 0=none, 1=urgent, 2=high, 3=normal, 4=low (optional)
# Output: JSON { id, identifier, title, parent_id }

set -euo pipefail

if [[ $# -lt 5 ]]; then
  echo "Usage: create-sub-issue.sh <team-id> <project-id> <state-id> <parent-id> <title> [priority]" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_graphql.sh"

PRIORITY="${6:-0}"

variables=$(jq -n \
  --arg teamId "$1" \
  --arg projectId "$2" \
  --arg stateId "$3" \
  --arg parentId "$4" \
  --arg title "$5" \
  --argjson priority "$PRIORITY" \
  '{teamId: $teamId, projectId: $projectId, stateId: $stateId, parentId: $parentId, title: $title, priority: $priority}')

response=$(_linear_graphql '
  mutation($teamId: String!, $projectId: String!, $stateId: String!, $parentId: String!, $title: String!, $priority: Int!) {
    issueCreate(input: {
      teamId: $teamId,
      projectId: $projectId,
      stateId: $stateId,
      parentId: $parentId,
      title: $title,
      priority: $priority
    }) {
      success
      issue { id identifier title parent { id } }
    }
  }
' "$variables")

success=$(echo "$response" | jq -r '.data.issueCreate.success')
if [[ "$success" != "true" ]]; then
  echo "Error: Failed to create sub-issue" >&2
  exit 1
fi

echo "$response" | jq '{
  id: .data.issueCreate.issue.id,
  identifier: .data.issueCreate.issue.identifier,
  title: .data.issueCreate.issue.title,
  parent_id: .data.issueCreate.issue.parent.id
}'
