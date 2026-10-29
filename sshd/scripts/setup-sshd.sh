#!/bin/sh
set -eu

USER_NAME="${SSH_USER:-sshuser}"
OPKSSH_VERSION="${OPKSSH_VERSION:-0.4.0}"
SSHD_CONFIG="/etc/ssh/sshd_config"
POLICY_FILE="/etc/opk/auth_id"
CLIENT_ID="${CLIENT_ID:-}"

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
  # gcompat provides the glibc loader shim (/lib64/ld-linux-x86-64.so.2) so
  # the glibc-linked opkssh binary runs on Alpine (musl).
  apk add --no-cache curl gcompat
  curl -fsSL \
    "https://github.com/openpubkey/opkssh/releases/download/v${OPKSSH_VERSION}/opkssh-linux-${ARCH}" \
    -o /usr/local/bin/opkssh
  chmod 755 /usr/local/bin/opkssh
fi

# 3. Create the user only if it doesn't exist; unlock the account so sshd
#    allows public-key auth (adduser -D leaves the password locked with '!').
if ! id "${USER_NAME}" >/dev/null 2>&1; then
  adduser -D "${USER_NAME}"
fi
passwd -u "${USER_NAME}" 2>/dev/null || true

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
set_option AuthorizedKeysCommandUser opksshuser
set_option AuthorizedPrincipalsFile /etc/opk/principals/%u

# 6. Create opksshuser (dedicated unprivileged user for AuthorizedKeysCommand)
if ! id opksshuser >/dev/null 2>&1; then
  adduser -D -H -s /sbin/nologin opksshuser
fi

# 7. Write opkssh policy from env vars, then set group ownership for opksshuser
mkdir -p /etc/opk
if [ -z "${REMOTE_USER_EMAIL:-}" ] || [ -z "${OIDC_ISSUER:-}" ] || [ -z "${KEY_EXPIRATION:-}" ] || [ -z "${CLIENT_ID:-}" ]; then
  echo "error: REMOTE_USER_EMAIL, OIDC_ISSUER, CLIENT_ID, and KEY_EXPIRATION must be set" >&2
  exit 1
fi
printf '%s %s %s\n' "${USER_NAME}" "${REMOTE_USER_EMAIL}" "${OIDC_ISSUER}" > "${POLICY_FILE}"
chown root:opksshuser "${POLICY_FILE}"
chmod 640 "${POLICY_FILE}"
printf '%s %s %s\n' "${OIDC_ISSUER}" "${CLIENT_ID}" "${KEY_EXPIRATION}" > /etc/opk/providers
chown root:opksshuser /etc/opk/providers
chmod 640 /etc/opk/providers

# Write the authorized principals file: maps SSH username → authorized OIDC email.
# sshd uses this to accept opkssh certificates whose principal is the user's email.
mkdir -p /etc/opk/principals
echo "${REMOTE_USER_EMAIL}" > "/etc/opk/principals/${USER_NAME}"
chmod 644 "/etc/opk/principals/${USER_NAME}"

# Create log file with correct ownership so opksshuser can write to it
touch /var/log/opkssh.log
chown root:opksshuser /var/log/opkssh.log
chmod 660 /var/log/opkssh.log

# 8. Start sshd in the foreground
mkdir -p /run/sshd
exec /usr/sbin/sshd -D -e
