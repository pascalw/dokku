#!/usr/bin/env bash

is_number() {
  local NUMBER=$1; local NUM_RE='^[1-4]+$'
  if [[ $NUMBER =~ $NUM_RE ]]; then
    return 0
  else
    return 1
  fi
}

usage() {
  echo "usage: $0 1|2|3|4"
  exit 0
}

BATCH_NUM="$1"
is_number "$BATCH_NUM" || usage

TESTS=$(find "$(dirname "$0")/../unit" -maxdepth 1 -name "${BATCH_NUM}0*.bats" | sort -n | xargs)
echo "running the following tests $TESTS"
# shellcheck disable=SC2086
time for test in $TESTS; do
  echo $test
  time bats $test
done
