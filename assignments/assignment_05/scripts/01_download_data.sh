#!/bin/bash

set -ueo pipefail

# Download data file
wget https://gzahn.github.io/data/fastq_examples.tar
# Extracts tz content + puts into raw data folder
tar -xvf fastq_examples.tar -C data/raw
# Cleans up tz file
rm fastq_examples.tar
