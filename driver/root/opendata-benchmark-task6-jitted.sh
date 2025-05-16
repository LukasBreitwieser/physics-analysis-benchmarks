#/bin/bash

SCRIPT_DIR="$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")"
cd "$SCRIPT_DIR"

. ../util.sh

spack load hpctoolkit

. "$INSTALL_DIR/bin/thisroot.sh"

cd ../../opendata-benchmarks/tasks/6/
rm -r hpctoolkit-* || true

time root.exe -l -b -q rdataframe_jitted.C

hpcrun -t -e REALTIME root.exe -l -b -q rdataframe_jitted.C

HPCSTRUCT_CACHE="$PROJECT_ROOT_DIR/tmp/hpcstruct-cache"
ls
set -x +e
for HPCTK_RESULT_DIR in hpctoolkit-*-measurements*; do
  #hpcstruct -j 1 -c "$HPCSTRUCT_CACHE" "$HPCTK_RESULT_DIR"
  hpcprof -j 1 "$HPCTK_RESULT_DIR"
done
