#!/bin/bash

#SBATCH --job-name=assignment_07

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --cpus-per-task=10

#SBATCH --time=12:00:00

#SBATCH --mem=64G

#SBATCH --mail-type=FAIL,BEGIN,END

#SBATCH --mail-user=hrsweazey@wm.edu

#SBATCH -o ./output/assignment_07.out

#SBATCH -e ./output/assignment_07.err

./scripts/01_download_data.sh
./scripts/02_clean_reads.sh
./scripts/03_map_reads.sh
