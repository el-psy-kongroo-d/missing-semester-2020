#!/usr/bin/env bash

marco() {
  MARCO_DIR=$(pwd) && echo "marco: saved current directory (${MARCO_DIR})"
}

polo() {
  if [[ -z "${MARCO_DIR}" ]]; then
    echo "polo: no saved directory — run marco first"
  else
    cd "${MARCO_DIR}" && echo "polo: moved back to ${MARCO_DIR}"
  fi
}