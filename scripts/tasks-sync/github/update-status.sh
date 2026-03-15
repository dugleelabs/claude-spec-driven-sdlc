#!/usr/bin/env bash
# Updates a project item's status field via GraphQL.
# Usage: ./update-status.sh <project-node-id> <item-node-id> <field-id> <option-id>
# Output: JSON { id } of updated item

set -euo pipefail

if [[ $# -lt 4 ]]; then
  echo "Usage: update-status.sh <project-node-id> <item-node-id> <field-id> <option-id>" >&2
  exit 1
fi

gh api graphql \
  -f query='
    mutation($projectId:ID!, $itemId:ID!, $fieldId:ID!, $optionId:String!) {
      updateProjectV2ItemFieldValue(input: {
        projectId: $projectId,
        itemId: $itemId,
        fieldId: $fieldId,
        value: { singleSelectOptionId: $optionId }
      }) {
        projectV2Item { id }
      }
    }' \
  -f projectId="$1" \
  -f itemId="$2" \
  -f fieldId="$3" \
  -f optionId="$4" \
  --jq '{id: .data.updateProjectV2ItemFieldValue.projectV2Item.id}'
