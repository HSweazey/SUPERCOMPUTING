#!/bin/bash

set -ueo pipefail

RAW_DATA_DIR="./data/raw/"
CLEAN_DATA_DIR="./data/clean/"

mkdir -p "$CLEAN_DATA_DIR"

for run in $(cut -d, -f1 ./data/SraRunTable.csv | tail -n +2); do
FWD_IN="${RAW_DATA_DIR}${run}_1.fastq.gz"
REV_IN="${RAW_DATA_DIR}${run}_2.fastq.gz"
FWD_OUT=${FWD_IN/$RAW_DATA_DIR/$CLEAN_DATA_DIR}
REV_OUT=${REV_IN/$RAW_DATA_DIR/$CLEAN_DATA_DIR}

if [[ -f "$FWD_OUT" && -f "$REV_OUT" ]]; then
        echo "Check: Cleaned data for ${run} already exists in ${CLEAN_DATA_DIR}. Skipping..."
        continue
    fi

fastp --in1 $FWD_IN --in2 $REV_IN --out1 $FWD_OUT --out2 $REV_OUT --json /dev/null \
--html /dev/null --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 \
--length_required 100 --average_qual 20

echo "Processed ${run}"
done
