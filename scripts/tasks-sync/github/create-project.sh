#!/usr/bin/env bash
# Creates a new GitHub Project.
# Usage: ./create-project.sh <owner> <title>
# Output: JSON { number, title, id, url }

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: create-project.sh <owner> <title>" >&2
  exit 1
fi

gh project create --owner "$1" --title "$2" --format json
