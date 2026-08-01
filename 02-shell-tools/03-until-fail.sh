#!/usr/bin/env bash

OUT=stdout.log
ERR=stderr.log
rm -f "${OUT}" "${ERR}"

CNT=0

while ./03-buggy.sh >> "${OUT}" 2>> "${ERR}";
do
  CNT=$((CNT+1))
done

echo "failed after $((CNT + 1)) runs"

cat "${OUT}"
cat "${ERR}"