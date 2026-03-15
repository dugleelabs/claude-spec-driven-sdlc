#!/usr/bin/env bash
# Lists all projects for a GitHub org/user.
# Usage: ./list-projects.sh <owner>
# Output: JSON array of { number, title, id }

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: list-projects.sh <owner>" >&2
  exit 1
fi

gh project list --owner "$1" --format json
