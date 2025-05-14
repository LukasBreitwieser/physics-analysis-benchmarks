#/bin/bash

set -ex

SCRIPT_DIR=$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")
cd "$SCRIPT_DIR"

. util.sh
cd "$BUILD_DIR"

spack install hpctoolkit

