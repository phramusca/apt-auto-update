#!/usr/bin/env bash
# Builds the apt-auto-update .deb package from repository root (debhelper source package).
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
SRC_DIR="${SCRIPT_DIR}/apt-auto-update"

command -v dpkg-buildpackage >/dev/null 2>&1 || {
  echo "Error: dpkg-buildpackage is required (sudo apt install build-essential debhelper fakeroot)." >&2
  exit 1
}

(cd "$SRC_DIR" && dpkg-buildpackage -us -uc -b -rfakeroot)

version="$(dpkg-parsechangelog -l "${SRC_DIR}/debian/changelog" -SVersion)"
echo "Package built: ${SCRIPT_DIR}/apt-auto-update_${version}_all.deb"
