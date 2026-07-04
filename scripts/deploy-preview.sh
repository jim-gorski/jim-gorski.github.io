#!/usr/bin/env bash
set -euo pipefail

preview_root="${WEBSITE_PREVIEW_ROOT:-/srv/www-preview}"
source_dir="${WEBSITE_OUTPUT_DIR:-output}"
source_sha="$(git rev-parse HEAD)"
release_dir="$preview_root/releases/$source_sha"
tmp_dir="$preview_root/releases/.tmp-$source_sha-$$"

case "$preview_root" in
  /srv/www-preview | /srv/www-preview/*) ;;
  *)
    printf 'ERROR: Refusing unexpected preview root: %s\n' "$preview_root" >&2
    exit 1
    ;;
esac

[ -s "$source_dir/index.html" ] || {
  printf 'ERROR: Missing generated site: %s/index.html\n' "$source_dir" >&2
  exit 1
}

install -d -m 0755 "$preview_root/releases"
rm -rf "$tmp_dir"
install -d -m 0755 "$tmp_dir"

rsync -a --delete "$source_dir/" "$tmp_dir/"
printf '%s\n' "$source_sha" > "$tmp_dir/.preview-commit"
cat > "$tmp_dir/.preview.json" <<JSON
{
  "commit": "$source_sha",
  "ref": "${GITEA_REF:-${GITHUB_REF:-unknown}}",
  "built_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
JSON

rm -rf "$release_dir"
mv "$tmp_dir" "$release_dir"
ln -sfn "$release_dir" "$preview_root/current.next"
mv -Tf "$preview_root/current.next" "$preview_root/current"

printf 'Preview published: %s -> %s\n' "$source_sha" "$preview_root/current"
