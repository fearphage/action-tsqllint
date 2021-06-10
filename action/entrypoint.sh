#!/usr/bin/env sh

echo "::add-matcher::$(dirname $0)/tsqllint-matcher.json"

echo "Running tsqllint on '$INPUT_PATH' with the following options:"

command_args=""

echo "- config path: '$INPUT_CONFIG_PATH'"
if [ -n "$INPUT_CONFIG_PATH" ]; then
  command_args="$command_args --config $INPUT_CONFIG_PATH"
fi

echo "- path: '$INPUT_PATH'"
command_args="$command_args $INPUT_PATH"

echo "Resulting command: tsqllint $command_args"

tsqllint $command_args
code=$?

if [ "$code" -eq 0 ]; then
  echo "TSQLLint found no problems"
else
  echo "TSQLLint found one or more problems"
fi

echo '::remove-matcher owner=tsqlint::'

if [ -n "$INPUT_WARN_ONLY" ]; then
  exit 0
else
  exit $code
fi
