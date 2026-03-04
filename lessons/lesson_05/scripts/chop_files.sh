#!/bin/bash

for FWD in ${DATA_DIR}*R1_*
do REV=${FWD/_R1_/_R2_}
OUT=${FWD%_L001_R1_sample.fastq}_interleaved_chop_${1}.fastq
echo $FWD $REV $OUT $1
./scripts/interleave_chop.sh $FWD $REV $OUT $1
done
