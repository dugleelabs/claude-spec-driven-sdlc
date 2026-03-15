#!/usr/bin/env bash
# Creates a draft item in a GitHub Project.
# Usage: ./create-item.sh <project-number> <owner> <title>
# Output: JSON { id, title }

set -euo pipefail

if [[ $# -lt 3 ]]; then
  echo "Usage: create-item.sh <project-number> <owner> <title>" >&2
  exit 1
fi

gh project item-create "$1" --owner "$2" --title "$3" --format json
