#!/usr/bin/env bash

set -e
set -x

if [ -z "$TOXENV" ]; then
  python -m pip install coverage
else
  # Add last TOXENV to $PATH.
  PATH="$PWD/.tox/${TOXENV##*,}/bin:$PATH"
fi

python -m coverage combine
python -m coverage xml
python -m coverage report -m
curl -S -L --retry 3 -s https://codecov.io/bash -o codecov-upload.sh
bash codecov-upload.sh -Z -X fix -f coverage.xml