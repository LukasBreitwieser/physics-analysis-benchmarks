#/bin/bash

SCRIPT_DIR="$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")"
cd "$SCRIPT_DIR"

. util.sh

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

if [[ "$BUILD_VARIANT" == "" ]]; then
  cmake \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DLLVM_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -Dxrootd=off \
    -Dx11=off \
    -Dminimal=off \
    -Droottest=off \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    ../../root


elif [[ "$BUILD_VARIANT" == "cpp23" ]]; then
  cmake \
    -DCMAKE_CXX_STANDARD=23 \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DLLVM_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -Dxrootd=off \
    -Dx11=off \
    -Dminimal=on \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    ../../root
else
  echo "ERROR unknown build variant"
  exit 1
fi


