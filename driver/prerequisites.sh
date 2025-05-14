#/bin/bash

set -ex

SCRIPT_DIR=$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")
cd "$SCRIPT_DIR"

. util.sh
cd "$BUILD_DIR"

if [ command spack &>/dev/null ]; then
  echo "ERROR spack was not found"
  echo "Please make sure spack is installed on your system, added to the PATH,"
  echo "and has the shell extension sourced"
  echo "Aborting..."
fi

spack install hpctoolkit

