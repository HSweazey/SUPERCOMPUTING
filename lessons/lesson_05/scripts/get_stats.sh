#!/bin/bash

# take files as input
echo $SHARED_DIR
# run seqkit stats on them all
seqkit stats ${SHARED_DIR}/lesson_05/data/*.fastq > ./output/stats.tsv
# export results
