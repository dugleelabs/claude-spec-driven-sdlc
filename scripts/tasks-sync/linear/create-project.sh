#!/usr/bin/env bash
# Creates a new Linear project.
# Usage: ./create-project.sh <name> <team-id>
# Output: JSON { id, name }

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: create-project.sh <name> <team-id>" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_graphql.sh"

variables=$(jq -n --arg name "$1" --arg teamId "$2" '{name: $name, teamIds: [$teamId]}')
response=$(_linear_graphql '
  mutation($name: String!, $teamIds: [String!]!) {
    projectCreate(input: { name: $name, teamIds: $teamIds }) {
      success
      project { id name }
    }
  }
' "$variables")

success=$(echo "$response" | jq -r '.data.projectCreate.success')
if [[ "$success" != "true" ]]; then
  echo "Error: Failed to create project" >&2
  exit 1
fi

echo "$response" | jq '{id: .data.projectCreate.project.id, name: .data.projectCreate.project.name}'
