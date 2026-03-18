# Supercomputing Assignment 6 and Setup Guide
**Name:** Hannah Sweazey

**Due Date:** March 19, 2026

In this assignment, we were tasked with:
- Developing and running three different installation methods
- Creating a multi-stage pipeline
- Utilizing good and clean project directory practices

## Project Specs and Info

*Below is the project directory structure.*

```text
assignment_06/
├── README.md
├── pipeline.sh
├── flye-env.yaml
├── assemblies/
│   ├─ assembly_conda
│   │  ├─ conda_assembly.fasta
│   │  └─ conda_flye.log
│   ├─ assembly_local
│   │  ├─ local_assembly.fasta
│   │  └─ local_flye.log
│   └─ assembly_module
│      ├─ module_assembly.fasta
│      └─ module_flye.log
├── scripts/
│   ├─ 01_download_data.sh
│   ├─ 02_flye_2.9.5_conda_install.sh
│   ├─ 02_flye_2.9.5_manual_build.sh
│   ├─ 03_run_flye_conda.sh
│   ├─ 03_run_flye_local.sh
│   └─ 03_run_flye_module.sh
└── data/
    └─ SRR33939694.fastq.gz
```

### pipeline.sh

This what what you must call to run the project.

```bash
./pipeline.sh
```
It will:
1. Download the data
2. Set up a conda environment
3. Clone the Flye GitHub
4. Use all three installations of Flye on the data
5. Compare results to check for consistency

### 01_download_data.sh

This script downloads genomic data for ecoli. It will move it into the data/ directory

### 02_flye_2.9.5_condal_install.sh

This script prepares flye in a conda environment. It creates an environment, activates it, checks to version, and deactivates. This also creates the
flye-env.yaml file to ensure environmental consistency.

### 02_flye_2.9.5_manual_build.sh

This script downloads to Flye GitHub repository into the user's ~/programs directory. It also adds its location to the user's $PATH for ease of use

### 03_run_flye_conda.sh

This script actually runs the conda-installed version of Flye on the data, removing excess files while keeping the log and the fasta file. It puts these
into the designated assembly_conda/ directory.

### 03_run_flye_local.sh

This script runs the local (GitHub) version of Flye on the data, removing excess files while keeping the log and fasta file. It puts these into the
designated assembly_local/ directory

### 03_run_flye_module.sh

This script runs the module (HPC) version of Flye on the data, removing excess files while keeping the log and fasta file. It puts these into the
designated assembly_module/ directory.

## Reflection and Thought Process

The code for this project was relatively simple when it was broken down into small parts. The biggest challenge arose from file paths as well as
(surprisingly) the pipefail. When I was setting up the conda environment, if I had the 'set -ueo pipefail' line, it would not activate the environment
because everything was isolated in a child terminal. There was also a general challenge with the pipefail in developing the pipeline. If one small issue
arose, it would stop whatever script it was in which left gaps in the workflow. This made me more proficient in debugging as well as exposing me to some
seemingly common developer issues to look out for in the future.

I wasn't aware of how many different installation tactics there were. I have dabbled a little in virtual environments before, but it didn't occur to me
that we would be using them on the HPC as well. I also did not know about module libraries before this class and this assignment helped illuminate
what exactly it is and the difference between the others. I think my preferred installation method is using a module. The module method is very easy and 
straightforward, it is only a matter of if the admins have installed the specific module you are interested in. Conda installation would be my second
preference. While it is a little more technical than a local installation, there is comfort in isolating a project in its own environment. I could see how
local installations could get a little messy quickly. With the conda installation, you also don't need to mess with you .bashrc which is good if you
are planning to share it with multiple other developers. I think I will use the conda method in future assignments if the module is not present on the HPC
already.
