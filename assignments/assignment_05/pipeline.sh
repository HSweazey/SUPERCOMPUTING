#!/bin/bash
set -ueo pipefail

# Download data
./scripts/01_download_data.sh

# For loop to trim data in data/raw
for file in data/raw/*_R1_*fastq.gz;
do ./scripts/02_run_fastp.sh ${file};
done
