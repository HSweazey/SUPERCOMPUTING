#!/bin/bash

module load miniforge3/
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate bbmap-env

CLEAN_DATA_DIR="./data/clean"
DOG_REFERENCE="./data/dog_reference/dog_reference_genome.fna"
OUTPUT_DIR="./output/"

mkdir -p "$OUTPUT_DIR"

bbmap.sh ref=$DOG_REFERENCE -Xmx16g

for run in $(cut -d, -f1 ./data/SraRunTable.csv | tail -n +2); do

bbmap.sh in1=$CLEAN_DATA_DIR/${run}_1.fastq.gz in2=$CLEAN_DATA_DIR/${run}_2.fastq.gz \
out=$OUTPUT_DIR/${run}.sam minid=0.95 -Xmx16g

samtools view -h -F 4 $OUTPUT_DIR/${run}.sam > $OUTPUT_DIR/${run}_dog-matches.sam
done
