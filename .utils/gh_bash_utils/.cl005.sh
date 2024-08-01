#!/bin/bash

FILE=$1
COUNT=$2

FILENAME="${FILE%.*}"
FILEEXTENSION="${FILE##*.}"

for ((i=1; i<=$COUNT; i++)); do
  NEWFILENAME="${FILENAME}_${i}.${FILEEXTENSION}"
  cp "$FILE" "$NEWFILENAME"
done
