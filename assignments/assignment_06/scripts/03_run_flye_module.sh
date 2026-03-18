#!/bin/bash

module load Flye/gcc-11.4.1/2.9.6

flye --nano-hq ./data/SRR33939694.fastq.gz --meta -g 100k -t 4 -o ./assemblies/assembly_module

mv ./assemblies/assembly_module/assembly.fasta ./assemblies/assembly_module/module_assembly.fasta
mv ./assemblies/assembly_module/flye.log ./assemblies/assembly_module/module_flye.log

for file in $(ls ./assemblies/assembly_module/ | grep -vE '\.fasta$|\.log$');
do rm -rf ./assemblies/assembly_module/$file;
done
