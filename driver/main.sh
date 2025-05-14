#/bin/bash

set -ex

SCRIPT_DIR=$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")
cd "$SCRIPT_DIR"

./prequisites.sh
./download-data.sh
# build ROOT
./configure.sh
./compile.sh

./root/opendata-benchmark-task6-jitted.sh
./root/opendata-benchmark-task6-compiled.sh

