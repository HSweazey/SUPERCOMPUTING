#!/bin/bash

set -ueo pipefail

DATA_DIR="$HOME/SUPERCOMPUTING/assignments/assignment_07/data"
CSV_FILE="$DATA_DIR/SraRunTable.csv"
DOG_DIR="$DATA_DIR/dog_reference"
RAW_DATA_DIR="$DATA_DIR/raw"

mkdir -p "$DOG_DIR" "$RAW_DATA_DIR"

datasets download genome taxon "Canis familiaris" --reference --include genome --filename "$DOG_DIR/dog_reference.zip"
unzip -j "$DOG_DIR/dog_reference.zip" "*.fna" -d "$DOG_DIR"

rm "$DOG_DIR/dog_reference.zip"
mv data/dog_reference/GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna  data/dog_reference/dog_reference_genome.fna

for run in $(cut -d, -f1 "$CSV_FILE" | tail -n +2); do

FWD_FILE="${RAW_DATA_DIR}/${run}_1.fastq.gz"
REV_FILE="${RAW_DATA_DIR}/${run}_2.fastq.gz"

if [[ -f "$FWD_FILE" && -f "$REV_FILE" ]]; then
      echo "Check: ${run} already exists in ${RAW_DATA_DIR}. Skipping download..."
      continue
fi

fasterq-dump "$run" --outdir "$RAW_DATA_DIR" --split-files

gzip "$RAW_DATA_DIR/${run}_1.fastq" "$RAW_DATA_DIR/${run}_2.fastq"

done
