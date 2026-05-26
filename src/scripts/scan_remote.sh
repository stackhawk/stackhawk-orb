#!/usr/bin/env bash
# Run HawkScan natively against a remote host. Inputs are provided as SHAWK_*
# environment variables by the job's `environment:` block (which is where orb
# parameter interpolation happens).
set -euo pipefail

# Defer key expansion to BASH_ENV so the secret value is never echoed here:
# api-key is an env_var_name parameter, so write a reference to that variable.
{
  echo "export API_KEY=\${${SHAWK_API_KEY_NAME}}"
  echo "export NO_COLOR=${SHAWK_NO_COLOR}"
} >> "${BASH_ENV}"

# Only export optional runtime variables when they are set.
append_export() {
  local name="$1" value="$2"
  if [ -n "${value}" ]; then
    echo "export ${name}=${value}" >> "${BASH_ENV}"
  fi
}

append_export APP_ID "${SHAWK_APP_ID}"
append_export HOST "${SHAWK_HOST}"
append_export ENV "${SHAWK_ENV}"
append_export USERNAME "${SHAWK_USERNAME}"
append_export PASSWORD "${SHAWK_PASSWORD}"
append_export AUTH_TOKEN "${SHAWK_AUTH_TOKEN}"

# shellcheck disable=SC1090
source "${BASH_ENV}"

# SHAWK_CONFIG_FILES is a space-separated list and must word-split.
# shellcheck disable=SC2086
shawk ${SHAWK_CONFIG_FILES}
