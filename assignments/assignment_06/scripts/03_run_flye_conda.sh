#!/bin/bash

module load miniforge3
source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh
conda activate flye-env

flye --nano-hq ./data/SRR33939694.fastq.gz --meta -g 100k -t 4 -o ./assemblies/assembly_conda

mv ./assemblies/assembly_conda/assembly.fasta ./assemblies/assembly_conda/conda_assembly.fasta
mv ./assemblies/assembly_conda/flye.log ./assemblies/assembly_conda/conda_flye.log

for file in $(ls ./assemblies/assembly_conda/ | grep -vE '\.fasta$|\.log$');
do rm -rf ./assemblies/assembly_conda/$file;
done

conda deactivate
