#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_PUBLISH_CREDENTIAL:?GITHUB_PUBLISH_CREDENTIAL is required}"

github_repo="https://github.com/jim-gorski/jim-gorski.github.io.git"
github_api="https://api.github.com/repos/jim-gorski/jim-gorski.github.io"
source_sha="$(git rev-parse HEAD)"
askpass_file="$(mktemp)"
publish_dir="$(mktemp -d)"

cleanup() {
  rm -f "$askpass_file"
  rm -rf "$publish_dir"
}
trap cleanup EXIT

cat >"$askpass_file" <<'ASKPASS'
#!/usr/bin/env sh
case "$1" in
  *Username*) printf '%s\n' 'x-access-token' ;;
  *Password*) printf '%s\n' "$GITHUB_PUBLISH_CREDENTIAL" ;;
  *) exit 1 ;;
esac
ASKPASS
chmod 700 "$askpass_file"

export GIT_ASKPASS="$askpass_file"
export GIT_TERMINAL_PROMPT=0

git push "$github_repo" HEAD:refs/heads/main

curl --fail-with-body --silent --show-error \
  --user "x-access-token:${GITHUB_PUBLISH_CREDENTIAL}" \
  --header "Accept: application/vnd.github+json" \
  --header "X-GitHub-Api-Version: 2022-11-28" \
  --request PUT \
  --data '{"source":{"branch":"gh-pages","path":"/"}}' \
  "${github_api}/pages"

curl --fail-with-body --silent --show-error \
  --user "x-access-token:${GITHUB_PUBLISH_CREDENTIAL}" \
  --header "Accept: application/vnd.github+json" \
  --header "X-GitHub-Api-Version: 2022-11-28" \
  --request PUT \
  --data '{"enabled":false}' \
  "${github_api}/actions/permissions"

rsync -a output/ "$publish_dir/"
git -C "$publish_dir" init --initial-branch=gh-pages
git -C "$publish_dir" config user.name "website-runner"
git -C "$publish_dir" config user.email "jim@jimgorski.com"
git -C "$publish_dir" add --all
git -C "$publish_dir" commit -m "Publish ${source_sha}"
git -C "$publish_dir" push --force "$github_repo" HEAD:refs/heads/gh-pages
