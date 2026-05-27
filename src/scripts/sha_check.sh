#!/usr/bin/env bash
# Optional pre-scan dedup. This script only runs when the commit_sha_check
# parameter is true (gated by a `when:` condition in the job). It looks up an
# existing StackHawk scan tagged with the current commit SHA and, if one exists,
# skips the scan (mirrors the hawkscan-action commitShaCheck). Relies on the scan
# being tagged `_STACKHAWK_GIT_COMMIT_SHA: ${CIRCLE_SHA1}` in stackhawk.yml — the
# tag the StackHawk platform actually indexes for commit lookups.
#
# This is a safe dedup: any missing prerequisite falls back to a normal scan.
# Note: unlike the GitHub Action it does NOT (yet) propagate the prior scan's
# pass/fail threshold result — it only skips re-scanning.
set -euo pipefail

echo "commit_sha_check: enabled; checking for an existing scan for this commit..."

fallback() {
  echo "commit_sha_check: $1 Running a normal scan."
  exit 0
}

command -v curl >/dev/null 2>&1 || fallback "curl is unavailable."

commit_sha="${CIRCLE_SHA1:-}"
[ -n "${commit_sha}" ] || fallback "CIRCLE_SHA1 is not set."

org_id="${SHAWK_ORG_ID:-}"
[ -n "${org_id}" ] || fallback "no organization_id was provided (required for the lookup)."

# applicationId: prefer the app_id parameter, else read it from the first
# configuration file that declares a concrete (non-templated) one.
app_id="${SHAWK_APP_ID:-}"
if [ -z "${app_id}" ]; then
  for cfg in ${SHAWK_CONFIG_FILES}; do
    [ -f "${cfg}" ] || continue
    app_id=$(sed -n -E 's/^[[:space:]]*applicationId:[[:space:]]*["'\'']?([^"'\'' ]+).*/\1/p' "${cfg}" | head -1)
    [ -n "${app_id}" ] && break
  done
fi
# Matching the literal characters '${' (an unresolved template), not expanding.
# shellcheck disable=SC2016
case "${app_id}" in
  '' | *'${'*) fallback "could not resolve a concrete applicationId." ;;
esac

api_base="https://api.stackhawk.com"
api_key_value="${!SHAWK_API_KEY_NAME}"

token=$(curl -sf -H "X-ApiKey: ${api_key_value}" -H "Accept: application/json" \
  "${api_base}/api/v1/auth/login" \
  | sed -n -E 's/.*"token"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/p') || true
[ -n "${token:-}" ] || fallback "StackHawk authentication failed."

echo "commit_sha_check: looking for an existing scan for commit ${commit_sha}..."
response=$(curl -sf -H "Authorization: Bearer ${token}" -H "Accept: application/json" \
  "${api_base}/api/v1/scan/${org_id}?appIds=${app_id}&tag=_STACKHAWK_GIT_COMMIT_SHA:${commit_sha}*&sortDir=desc&pageSize=1") \
  || fallback "scan lookup request failed."

total=$(printf '%s' "${response}" | sed -n -E 's/.*"totalCount"[[:space:]]*:[[:space:]]*([0-9]+).*/\1/p')
case "${total}" in '' | *[!0-9]*) total=0 ;; esac

if [ "${total}" -gt 0 ]; then
  scan_id=$(printf '%s' "${response}" | sed -n -E 's/.*"scan":\{"id":"([0-9a-fA-F-]+)".*/\1/p' | head -1)
  echo "commit_sha_check: found an existing scan for commit ${commit_sha}; skipping the scan."
  [ -n "${scan_id}" ] && echo "View on StackHawk platform: https://app.stackhawk.com/scans/${scan_id}"
  circleci step halt
else
  echo "commit_sha_check: no existing scan for ${commit_sha}; running a normal scan."
fi
