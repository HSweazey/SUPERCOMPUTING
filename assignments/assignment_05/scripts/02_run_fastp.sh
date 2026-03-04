#!/bin/bash
set -ueo pipefail

# Takes name of FWD file, derives the reverse
FWD_IN=$1
REV_IN=${FWD_IN/_R1_/_R2_}
FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}
REV_OUT=${REV_IN/.fastq.gz/.trimmed.fastq.gz}
SAMPLE_NAME=$(basename "$FWD_IN" _R1_001.subset.fastq.gz)

fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/trimmed} --out2 ${REV_OUT/raw/trimmed} --json /dev/null \
--html "./log/${SAMPLE_NAME}_fastp.html" --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 \
--length_required 100 --average_qual 20

echo "Processed ${SAMPLE_NAME}"
