#/bin/bash

set -ex

SCRIPT_DIR=$(readlink -e "$(dirname "${BASH_SOURCE[0]}")")
cd "$SCRIPT_DIR"

. util.sh
mkdir -p "$PROJECT_ROOT_DIR/data"
cd "$PROJECT_ROOT_DIR/data"

if [ ! -f Run2012B_SingleMu.root ]; then
  wget --no-check-certificate https://eospublic.cern.ch//eos/root-eos/benchmark/Run2012B_SingleMu.root
fi

