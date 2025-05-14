#/bin/bash

SCRIPT_DIR="$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")"
cd "$SCRIPT_DIR"

. ../util.sh

. "$INSTALL_DIR/bin/thisroot.sh"

set -ex
cd ../../opendata-benchmarks/tasks/6/
rm -r hpctoolkit-* || true

g++ -O3 -o rdataframe_compiled rdataframe_compiled.cxx $(root-config --cflags --libs)

time ./rdataframe_compiled

hpcrun -t -e REALTIME ./rdataframe_compiled

HPCSTRUCT_CACHE="$PROJECT_ROOT_DIR/tmp/hpcstruct-cache"
for HPCTK_RESULT_DIR in hpctoolkit-*-measurements*; do
  # hpcstruct for libCling takes more than 64GB or RAM and is killed by the OOM daemon
  #hpcstruct -j 1 "$HPCTK_RESULT_DIR"
  hpcprof -j $(CpuCount) "$HPCTK_RESULT_DIR"
done

