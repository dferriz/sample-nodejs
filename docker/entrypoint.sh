#!/bin/sh

set -e

NODE_MODULES_DIR="node_modules"
PACKAGE_LOCK_FILE="package-lock.json"
CURRENT_CHECKSUM=$(md5sum "${PACKAGE_LOCK_FILE}" | awk '{print $1}')
CHECKSUM_DIR="${CHECKSUM_DIRECTORY_PATH}/${CURRENT_CHECKSUM}"

if [ -d "${CHECKSUM_DIR}" ]; then
    echo "✅ It looks like you've already build node_modules"
    rsync -a --delete --quiet "${CHECKSUM_DIR}/" "${NODE_MODULES_DIR}/"
else
    echo "🔄 Installing dependencies..."
    npm ci || npm install
    mkdir -p "${CHECKSUM_DIR}"
    rsync -a --delete --quiet "${NODE_MODULES_DIR}/" "${CHECKSUM_DIR}/"
    echo "🧹 Cleaning previously builds..."
    find "${CHECKSUM_DIRECTORY_PATH}" -mindepth 1 -maxdepth 1 -type d ! -name "${CURRENT_CHECKSUM}" -exec rm -rf {} +
fi

# Run command with node if the first argument contains a "-" or is not a system command. The last
# part inside the "{}" is a workaround for the following bug in ash/dash:
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874264
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ] || { [ -f "${1}" ] && ! [ -x "${1}" ]; }; then
  set -- node "$@"
fi

exec "$@"
