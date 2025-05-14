#/bin/bash

DEFAULT_BUILD_TYPE=RelWithDebInfo

set -e

function help {
  echo "Usage"
  echo " $0 BUILD_TYPE [BUILD_VARIANT]"
  echo "    BUILD_TYPE (Release, Debug, or RelWithDebInfo)"
  echo "              Default: $DEFAULT_BUILD_TYPE"
  echo "    BUILD_VARIANT (optional) is appended to the build dir path"
  echo "        build/{BUILD_TYPE}{BUILD_VARIANT}"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  help
  exit
fi

if [[ "$#" -gt "2" ]]; then
  echo "ERROR wrong number of arguments"
  help
  exit 1
fi

BUILD_TYPE=${1:-$DEFAULT_BUILD_TYPE}
BUILD_VARIANT=""
if [[ "$#" == "2" ]]; then
  shift
  BUILD_VARIANT=$1
fi

if [[ ! "$BUILD_TYPE" =~ ^(Release|Debug|RelWithDebInfo)$ ]]; then
  echo "ERROR BUILD_TYPE must be one of Release, Debug, RelWithDebInfo"
  help
  exit 1
fi

SCRIPT_DIR="$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")"

export PROJECT_ROOT_DIR="$(readlink -e "$SCRIPT_DIR/..")"
export BUILD_DIR="$(readlink -e "$SCRIPT_DIR/..")/build/$BUILD_TYPE$BUILD_VARIANT"
export INSTALL_DIR="$(readlink -e "$SCRIPT_DIR/..")/install/$BUILD_TYPE$BUILD_VARIANT"
echo "$SCRIPT_DIR"

echo "Info:"
echo "BUILD_TYPE:    $BUILD_TYPE"
echo "BUILD_VARIANT: $BUILD_VARIANT"
echo "BUILD_DIR:     $BUILD_DIR"
echo "INSTALL_DIR:   $INSTALL_DIR"
echo ""

# Returns the number of CPU cores including hyperthreads
function CPUCount {
  grep -c ^processor /proc/cpuinfo
}
