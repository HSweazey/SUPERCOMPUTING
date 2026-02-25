#!/bin/bash
set -ueo pipefail

fasta=$1

echo "Beginning analysis on ${fasta}"

num_seqs=$(seqtk comp $fasta | wc -l)
num_nuc=$(grep -v "^[>,\n]" $fasta | wc -c)
summary_table=$(seqtk comp $fasta)

echo "Total number of sequences in ${fasta}"
echo "$num_seqs"
echo "Total number of nucleotides in ${fasta}"
echo "$num_nuc"
echo "Summary table of sequences in ${fasta}. Columns are name, length, A, C, G, T, N, other"
echo "$summary_table"

