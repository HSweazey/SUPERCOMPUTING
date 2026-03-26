# Supercomputing Assignment 7 and Setup Guide
**Name:** Hannah Sweazey

**Due Date:** March 26, 2026

In this assignment, we were tasked with:
- Developing a pipeline that downloads data, processes data, and logs output
- Sending our pipeline to slurm and tracking its progress
- Determining what slurm parameters are necessary for jobs
- Analyzing a sample of random metagenomic data for traces of dog genomes

## Project Specs and Info

*Below is the project directory structure. Some folders will not immediately appear upon downloading this repository. The pipeline will make these for you.*

```text
assignment_06/
├── README.md
├── assignment_07_pipeline.slurm
├── data/
│   ├─ clean/
│   ├─ raw/
│   └─ dog_reference/
└── scripts/
    ├─ 01_download_data.sh
    ├─ 02_clean_reads.sh
    └─ 03_map_reads.sh
```

### Requirements

To run this pipeline, there are three tools to install whose documentation I have linked below.

fasterq [https://github.com/ncbi/sra-tools] - "a collection of tools and libraries for using data in the INSDC Sequence Read Archives"

NCBI datasets [https://github.com/ncbi/datasets] - "a resource that lets you easily gather data from across NCBI databases"

fastp [https://github.com/OpenGene/fastp] - "a tool designed to provide ultrafast all-in-one preprocessing and quality control for FastQ data"

samtools [https://www.htslib.org/download/] - "a suite of programs for interacting with high-throughput sequencing data"

a conda environment with bbmap [https://bioconda.github.io/recipes/bbmap/README.html] - "a short read aligner, as well as various other bioinformatic tools"

Create a conda environment with the script below. If you already have a bbmap environment, load it in the script:
```bash
module load miniforge3
source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh
mamba create -y -n bbmap-env bbmap
conda activate bbmap-env
```

Be sure to add these to your ```$PATH``` so they are accessible from anywhere on your machine.

### assignment_07_pipeline.slurm

**BEFORE RUNNING THE PIPELINE** if you wish to set a different notification email, navigate to the ```assignment_07_pipeline.slurm``` script. Change the following line to reflect *your* email.

```bash
#SBATCH --mail-user=YOUR EMAIL HERE
```

This what what you must call to run the project (supposing you are in the assignment_07/ directory):

```bash
sbatch assignment_07_pipeline.slurm
```

It will:
1. Download the data (```01_download_data.sh```)
2. Clean and trim reads (```02_clean_reads.sh```)
3. Map those reads (```03_map_reads.sh```)

It asks for:
1. 1 node
2. 4 cpus
3. 4 hours of run time
4. 25G of memory

### 01_download_data.sh

This script downloads a random sample of metagenomic data from the NCBI database. The runs data is located in ```data/SraRunsTable.csv```. These were selected with a query of 'metagenomes,' filtered by the Illumina platform and the genome strategy. Using the ```datasets``` tool, this script downloads the reference genome for dogs, renames it, and moves it into the ```data/dog_reference/``` directory. It then uses the ```fasterq-dump``` function to download the genomes from the randomly selected dataset, moves them into the ```data/raw/``` directory, and compresses the files using ```gzip```.

### 02_clean_reads.sh

This script takes the run id for each genome, finds the FWD and REV paths for each and runs the ```fastp``` tool. I utilized a previous example we had run in class with the following parameters:

```bash
fastp --in1 $FWD_IN --in2 $REV_IN --out1 $FWD_OUT --out2 $REV_OUT --json /dev/null \
--html /dev/null --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 \
--length_required 100 --average_qual 20
```

### 03_map_reads.sh

This script uses ```bbmap.sh``` to map the filtered reads against the dog reference genome. It is run using the following parameters:

```bash
bbmap.sh in1=$CLEAN_DATA_DIR/${run}_1.fastq.gz in2=$CLEAN_DATA_DIR/${run}_2.fastq.gz \
out=$OUTPUT_DIR/${run}.sam minid=0.95 -Xmx16g
```
It then uses the ```samtools``` tool to extract any reads that had significant positive matches to the dog reference genome. Both mapping files are saved to the ```output/``` directory.

## Results Table

*I was unprepared for how long this pipeline would take. I originally alloted 4 hours and it only download 3 of the genomes. I tried to run the pipeline on the 3 genomes to verify its integrity, but that also took 4+ hours. I took a small bit of sample data to create a draft of what a finished table would look like. The following table was made when the first .map file was around 20% finished*

| Sample ID   | Total Reads | Dog-Mapped Reads |
| ---         | ---         | ---              |
| SRR37648994 | 4940393     | 125484           |

## Reflection and Thought Process

This was definitely the hardest project. I found it very hard to test my scripts and the sheer amount of time the job took made it hard to troubleshoot. This was largely due to the fact I had no clue how long it would take and many hours were wasted running the slurm script and it not being enough time (for exmaple, four hours for only 3 genomic sequences when we have only had slurm scripts take a handlful of minutes). I also found it difficult to get the data in the first place as I have never done anything biostats related so it took a second for me to identify what I was supposed to download. I also had no frame of reference for what other slurm parameters would be acceptable to request for this job. As mentioned, the practice we have done in class with slurm was all very small-scale, so with a bigger job like this one, I didn't know what a "good-neighbor" request would look like. I also don't know how to use a conda environment .yaml file to load an environment for users. It feels like there's a few pieces of my project missing because I don't recall going over what the next step is to calling that .yaml file to create an environment for the new user, or the typical time of a job of this nature, etc. It was, however, neat to see all of what we've learned come together. Building the pipeline was relatively seemless, it was just hard to debug in an efficient manner and I felt relatively unprepared for the sheer amount of time the pipeline took.
