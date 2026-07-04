#!/usr/bin/env bash
set -euo pipefail

preview_root="${WEBSITE_PREVIEW_ROOT:-/srv/www-preview}"
commit_file="$preview_root/current/.preview-commit"
source_sha="$(git rev-parse HEAD)"

if [ ! -s "$commit_file" ]; then
  printf 'ERROR: Preview commit marker is missing: %s\n' "$commit_file" >&2
  exit 1
fi

preview_sha="$(cat "$commit_file")"
if [ "$preview_sha" != "$source_sha" ]; then
  printf 'ERROR: Current preview is %s, but publish workflow is running %s.\n' "$preview_sha" "$source_sha" >&2
  printf 'Push and review this commit on https://www.jimgorski.net/ before publishing.\n' >&2
  exit 1
fi

printf 'Preview commit verified: %s\n' "$source_sha"
