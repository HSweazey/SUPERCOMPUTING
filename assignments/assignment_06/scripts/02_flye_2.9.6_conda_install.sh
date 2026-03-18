#!/bin/bash

module load miniforge3
source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh
mamba create -y -n flye-env flye -c bioconda
conda activate flye-env
conda env export --no-builds > flye-env.yml

flye -v

conda deactivate
