#!/bin/sh

set -e

if [ -f ".env.example" ]; then
    cp -n .env.example .env
fi

NODE_MODULES_DIR="node_modules"
PACKAGE_LOCK_FILE="package-lock.json"
CURRENT_CHECKSUM=$(md5sum "${PACKAGE_LOCK_FILE}" | awk '{print $1}')
CHECKSUM_DIR="${CHECKSUM_DIRECTORY_PATH}/${CURRENT_CHECKSUM}"

if [ -d "${NODE_MODULES_DIR}" ] && [ -d "${CHECKSUM_DIR}" ]; then
    echo "✅ It looks like you've already build node_modules"
    rm -rf node_modules/*
    cp -r ${CHECKSUM_DIR}/* node_modules
else
    echo "🔄 Installing dependencies..."
    npm ci || npm install
    rm -rf ${CHECKSUM_DIR}
    mkdir -p "${CHECKSUM_DIR}"
    cp -r  node_modules/* ${CHECKSUM_DIR}
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
