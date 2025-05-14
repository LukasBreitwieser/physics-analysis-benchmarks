#/bin/bash

SCRIPT_DIR="$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")"
cd "$SCRIPT_DIR"

. util.sh

cd "$BUILD_DIR"
make -j16
make install
