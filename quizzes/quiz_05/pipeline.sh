#!/bin/bash
set -ueo pipefail

# Prep data file by downloading, moving to data/raw/, and unzipping
./scripts/01_prep_data.sh

# Get summary stats using seqkit and put in a text file in output/
./scripts/02_get_stats.sh

# Remove tarball file (not needed after data extraction
./scripts/03_cleanup.sh
