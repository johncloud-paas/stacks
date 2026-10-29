#!/bin/sh
set -eu

USER_NAME="${SSH_USER:-sshuser}"
OPKSSH_VERSION="${OPKSSH_VERSION:-0.4.0}"
SSHD_CONFIG="/etc/ssh/sshd_config"
POLICY_FILE="/config/auth_id"
CLIENT_ID="${CLIENT_ID:-}"

# Persist SSH config and host keys via the /config volume
mkdir -p /config/etc
if [ -d /etc/ssh ] && [ ! -L /etc/ssh ]; then
  rm -rf /etc/ssh
fi
ln -sfn /config/etc /etc/ssh
HOME_DIR="/home/${USER_NAME}"

# 1. Install openssh only if sshd is missing
if ! command -v sshd >/dev/null 2>&1; then
  apk add --no-cache openssh
fi

# 2. Install opkssh only if missing
if ! command -v opkssh >/dev/null 2>&1; then
  ARCH=$(uname -m)
  case "${ARCH}" in
    x86_64)  ARCH=amd64 ;;
    aarch64) ARCH=arm64 ;;
    *) echo "error: unsupported arch ${ARCH}" >&2; exit 1 ;;
  esac
  apk add --no-cache curl
  curl -fsSL \
    "https://github.com/openpubkey/opkssh/releases/download/v${OPKSSH_VERSION}/opkssh-linux-${ARCH}" \
    -o /usr/local/bin/opkssh
  chmod 755 /usr/local/bin/opkssh
fi

# 3. Create the user only if it doesn't exist
if ! id "${USER_NAME}" >/dev/null 2>&1; then
  adduser -D "${USER_NAME}"
fi

# 4. Generate only missing host keys (ssh-keygen -A skips existing ones)
ssh-keygen -A

# 5. Set each sshd option once: replace the existing line or append a new one
set_option() {
  key="$1"
  value="$2"
  if grep -qE "^[#[:space:]]*${key}[[:space:]]" "${SSHD_CONFIG}"; then
    sed -i -E "s|^[#[:space:]]*${key}[[:space:]].*|${key} ${value}|" "${SSHD_CONFIG}"
  else
    echo "${key} ${value}" >> "${SSHD_CONFIG}"
  fi
}

set_option PasswordAuthentication no
set_option PubkeyAuthentication yes
set_option PermitRootLogin no
set_option AuthorizedKeysFile none
set_option AuthorizedKeysCommand "/usr/local/bin/opkssh verify %u %k %t"
set_option AuthorizedKeysCommandUser nobody

# 6. Write opkssh policy from env vars, then link it
mkdir -p /etc/opk
if [ -z "${REMOTE_USER_EMAIL:-}" ] || [ -z "${OIDC_ISSUER:-}" ] || [ -z "${KEY_EXPIRATION:-}" ] || [ -z "${CLIENT_ID:-}" ]; then
  echo "error: REMOTE_USER_EMAIL, OIDC_ISSUER, CLIENT_ID, and KEY_EXPIRATION must be set" >&2
  exit 1
fi
mkdir -p "$(dirname "${POLICY_FILE}")"
printf '%s %s %s\n' "${REMOTE_USER_EMAIL}" "${OIDC_ISSUER}" "${USER_NAME}" > "${POLICY_FILE}"
ln -sfn "${POLICY_FILE}" /etc/opk/auth_id
printf '%s %s %s\n' "${OIDC_ISSUER}" "${CLIENT_ID}" "${KEY_EXPIRATION}" > /etc/opk/providers

# 7. Start sshd in the foreground
mkdir -p /run/sshd
exec /usr/sbin/sshd -D -e
