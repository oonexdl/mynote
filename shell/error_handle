#!/bin/bash

PROGNAME=$(basename $0)

error_exit()
{
  # '1>&2' means standard output to error output
  echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
  exit 1
}

# The LINENO environment variable. It contains the current line number.

echo "Example of error with line number and message"
error_exit "$LINENO: An error has occurred."
