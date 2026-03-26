#!/bin/bash

#SBATCH --job-name=quiz

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --cpus-per-task=1

#SBATCH --time=1

#SBATCH --mem=1G

#SBATCH --mail-type=FAIL,BEGIN,END

#SBATCH --mail-user=hrsweazey@wm.edu

#SBATCH -o JOBNAME_%j.out #STDOUT to file (%j is jobID)

#SBATCH -e JOBNAME_%j.err #STDERR to file (%j is jobID)

echo "Hello world!"
