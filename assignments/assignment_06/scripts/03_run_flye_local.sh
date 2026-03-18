#!/bin/bash

flye --nano-hq ./data/SRR33939694.fastq.gz --meta -g 100k -t 4 -o ./assemblies/assembly_local

mv ./assemblies/assembly_local/assembly.fasta ./assemblies/assembly_local/local_assembly.fasta
mv ./assemblies/assembly_local/flye.log ./assemblies/assembly_local/local_flye.log

for file in $(ls ./assemblies/assembly_local/ | grep -vE '\.fasta$|\.log$');
do rm -rf ./assemblies/assembly_local/$file;
done
