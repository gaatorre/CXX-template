#!/bin/sh
set -e

# Environment variables
PROJ=template
NUM_PROC=$(nproc)
BUILD=Release

GIT_HOOK=./.git/hooks/pre-commit
if [ -f "$GIT_HOOK" ]; then
    echo > /dev/null
else
    ./scripts/init.sh
fi

usage() { echo "Usage: $0 [-d Builds in debug mode]" 1>&2; exit 1; }

while getopts "d" o; do
    case "${o}" in
        d)
	    BUILD=Debug
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Exporting Environmental variables
export PROJ
export BUILD

echo "Building project $PROJ"
echo "* Using $NUM_PROC cores"
echo "* Building with $BUILD"
echo

cmake -B build -S . && cmake --build build -j 4
