#!/usr/bin/env bash
# Run HawkScan from a Docker container on a CircleCI machine executor.
# Inputs are provided as SHAWK_* environment variables by the job's
# `environment:` block (which is where orb parameter interpolation happens).
set -euo pipefail

# api_key is an env_var_name parameter: SHAWK_API_KEY_NAME holds the NAME of
# the variable that stores the key, so resolve it indirectly.
api_key_value="${!SHAWK_API_KEY_NAME}"

docker_args=(run
  --network "${SHAWK_DOCKER_NETWORK}"
  --volume "$(pwd):/hawk"
  --tty
  --env "API_KEY=${api_key_value}"
  --env "NO_COLOR=${SHAWK_NO_COLOR}")

# Only pass optional runtime variables through when they are set.
append_env() {
  local name="$1" value="$2"
  if [ -n "${value}" ]; then
    docker_args+=(--env "${name}=${value}")
  fi
}

append_env APP_ID "${SHAWK_APP_ID}"
append_env HOST "${SHAWK_HOST}"
append_env ENV "${SHAWK_ENV}"
append_env USERNAME "${SHAWK_USERNAME}"
append_env PASSWORD "${SHAWK_PASSWORD}"
append_env AUTH_TOKEN "${SHAWK_AUTH_TOKEN}"

# Expose CircleCI's commit metadata so stackhawk.yml can resolve git tags
# (e.g. _STACKHAWK_GIT_COMMIT_SHA: ${CIRCLE_SHA1}) for commit-status/PR checks.
append_env CIRCLE_SHA1 "${CIRCLE_SHA1:-}"
append_env CIRCLE_BRANCH "${CIRCLE_BRANCH:-}"

docker_args+=("${SHAWK_DOCKER_IMAGE}")

# SHAWK_CONFIG_FILES is a space-separated list and must word-split.
# shellcheck disable=SC2086
docker "${docker_args[@]}" ${SHAWK_CONFIG_FILES}
