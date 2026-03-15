#!/usr/bin/env bash
# Gets workflow states for a team, returns the unstarted and completed state IDs.
# Usage: ./get-workflow-states.sh <team-id>
# Output: JSON { todo_state_id, todo_state_name, done_state_id, done_state_name }

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: get-workflow-states.sh <team-id>" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_graphql.sh"

variables=$(jq -n --arg id "$1" '{id: $id}')
response=$(_linear_graphql '
  query($id: String!) {
    team(id: $id) {
      states {
        nodes { id name type }
      }
    }
  }
' "$variables")

states=$(echo "$response" | jq '.data.team.states.nodes')

# Match by type field first (reliable)
todo_state=$(echo "$states" | jq -r '[.[] | select(.type == "unstarted")] | first // empty')
done_state=$(echo "$states" | jq -r '[.[] | select(.type == "completed")] | first // empty')

# Fallback to name matching if type matching fails
if [[ -z "$todo_state" || "$todo_state" == "null" ]]; then
  todo_state=$(echo "$states" | jq -r '[.[] | select(.name | test("^(Todo|To Do|Backlog)$"; "i"))] | first // empty')
  if [[ -n "$todo_state" && "$todo_state" != "null" ]]; then
    echo "Warning: No 'unstarted' type state found, falling back to name match: $(echo "$todo_state" | jq -r '.name')" >&2
  fi
fi

if [[ -z "$done_state" || "$done_state" == "null" ]]; then
  done_state=$(echo "$states" | jq -r '[.[] | select(.name | test("^(Done|Completed)$"; "i"))] | first // empty')
  if [[ -n "$done_state" && "$done_state" != "null" ]]; then
    echo "Warning: No 'completed' type state found, falling back to name match: $(echo "$done_state" | jq -r '.name')" >&2
  fi
fi

# Final validation
if [[ -z "$todo_state" || "$todo_state" == "null" ]]; then
  echo "Error: Could not find a todo/unstarted workflow state for this team" >&2
  echo "Available states:" >&2
  echo "$states" | jq -r '.[] | "  \(.name) (type: \(.type))"' >&2
  exit 1
fi

if [[ -z "$done_state" || "$done_state" == "null" ]]; then
  echo "Error: Could not find a done/completed workflow state for this team" >&2
  echo "Available states:" >&2
  echo "$states" | jq -r '.[] | "  \(.name) (type: \(.type))"' >&2
  exit 1
fi

jq -n \
  --arg todo_id "$(echo "$todo_state" | jq -r '.id')" \
  --arg todo_name "$(echo "$todo_state" | jq -r '.name')" \
  --arg done_id "$(echo "$done_state" | jq -r '.id')" \
  --arg done_name "$(echo "$done_state" | jq -r '.name')" \
  '{
    todo_state_id: $todo_id,
    todo_state_name: $todo_name,
    done_state_id: $done_id,
    done_state_name: $done_name
  }'
