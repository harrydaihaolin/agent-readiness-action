#!/usr/bin/env bash
# Move the floating major tag (v1) to a freshly-pushed vX.Y.Z tag.
# This is what `release.yml` does in CI; this script lets a maintainer
# do the same locally if the workflow can't (e.g., when retagging an
# already-published release).
#
# Usage: bin/release.sh v1.2.3

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "usage: $0 vX.Y.Z" >&2
  exit 2
fi

TAG="$1"
MAJOR="${TAG%%.*}"

if ! [[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Tag '$TAG' is not in the form vX.Y.Z" >&2
  exit 2
fi

git fetch --tags origin
git tag -fa "$MAJOR" -m "Floating major tag → ${TAG}" "$TAG"
git push --force origin "refs/tags/${MAJOR}"
echo "Moved ${MAJOR} → ${TAG}"
