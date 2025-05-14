#/bin/bash

set -ex

SCRIPT_DIR=$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")
cd "$SCRIPT_DIR"

. util.sh
cd "$BUILD_DIR"

set +e
# Add testing code below 
#ctest --output-on-failure -R tutorial-hsimple
#ctest --output-on-failure -R test-TFormulaTests
ctest -j12 --output-on-failure |& tee ctest.log
