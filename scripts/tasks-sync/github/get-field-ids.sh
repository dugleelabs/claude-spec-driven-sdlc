#!/usr/bin/env bash
# Gets the project node ID, Status field ID, and Todo/Done option IDs.
# Usage: ./get-field-ids.sh <project-number> <owner>
# Output: JSON { project_node_id, status_field_id, todo_option_id, done_option_id }

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: get-field-ids.sh <project-number> <owner>" >&2
  exit 1
fi

PROJECT_NUMBER="$1"
OWNER="$2"

# Get project node ID
PROJECT_NODE_ID=$(gh project view "$PROJECT_NUMBER" --owner "$OWNER" --format json --jq '.id')

if [[ -z "$PROJECT_NODE_ID" ]]; then
  echo "Error: Could not find project #$PROJECT_NUMBER for owner $OWNER" >&2
  exit 1
fi

# Get field list and extract Status field
FIELDS_JSON=$(gh project field-list "$PROJECT_NUMBER" --owner "$OWNER" --format json)

STATUS_FIELD_ID=$(echo "$FIELDS_JSON" | jq -r '.fields[] | select(.name == "Status") | .id')

if [[ -z "$STATUS_FIELD_ID" ]]; then
  echo "Error: Could not find Status field in project #$PROJECT_NUMBER" >&2
  exit 1
fi

# Extract Todo and Done option IDs from Status field options
TODO_OPTION_ID=$(echo "$FIELDS_JSON" | jq -r '.fields[] | select(.name == "Status") | .options[] | select(.name == "Todo") | .id')
DONE_OPTION_ID=$(echo "$FIELDS_JSON" | jq -r '.fields[] | select(.name == "Status") | .options[] | select(.name == "Done") | .id')

if [[ -z "$TODO_OPTION_ID" || -z "$DONE_OPTION_ID" ]]; then
  echo "Error: Could not find Todo/Done options in Status field" >&2
  echo "Available options:" >&2
  echo "$FIELDS_JSON" | jq -r '.fields[] | select(.name == "Status") | .options[] | .name' >&2
  exit 1
fi

jq -n \
  --arg project_node_id "$PROJECT_NODE_ID" \
  --arg status_field_id "$STATUS_FIELD_ID" \
  --arg todo_option_id "$TODO_OPTION_ID" \
  --arg done_option_id "$DONE_OPTION_ID" \
  '{
    project_node_id: $project_node_id,
    status_field_id: $status_field_id,
    todo_option_id: $todo_option_id,
    done_option_id: $done_option_id
  }'
