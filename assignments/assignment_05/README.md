# Supercomputing Assignment 5 and Setup Guide
**Name:** Hannah Sweazey

**Due Date:** March 4, 2026

In this assignment, we were tasked with:
- Downloading tools in our ./programs directory
- Developing scripts to trim and process fastq data
- Creating a pipeline to automate steps in the analysis process
- Using quality documentation techniques

## Tools and Prerequisites

To use this pipeline requires two things of your environment (assuming you are using bash).

### 1. Install the fastp tool

Navigate to your ./programs directory (or wherever you want to keep your tool) and install the fastp tool.
The following is a short script I developed for installation and cleaning. 
**Your path will be different, so change accordingly if you want to be able to access this tool from anywhere on your machine**

```bash
#!/bin/bash
set -ueo pipefail

wget http://opengene.org/fastp/fastp
chmod a+x ./fastp

echo 'export PATH=$PATH:/sciclone/home/hrsweazey/programs/fastp' >> ~/.bashrc
```

*This installed the latest version of the fastp tool which as of March 4, 2026 is version 1.1.0)*

### 2. Set up directory structure

*By downloading this GitHub, everything will be set up besides the data directory. This is where the data will download to and be processed in.*

```text
assignment_05/
├── README.md
├── pipeline.sh
├── log/
├── scripts/
│   ├─ 01_download_data.sh
│   └─ 02_run_fastp.sh
└── data/
    ├─ raw/
    └─ trimmed/
```
## The Pipeline

After the tool is downloaded and the data directory is added, you are ready to run the pipeline with the following command from assignment_05:

```bash
./pipeline.sh
```
### 01_download_data.sh

This file downloads the data and puts it directly into the data/raw/ directory. It removes the raw tarball file after the data is extracted.

### 02_run_fastp.sh

This file takes a filename as an argument when called, finds the out filename, reverse, and reverse out and calls the fastp tool. The HTML report
is then output to the log/ directory for each specific sample and trimmed versions of the data is output to data/trimmed/.

### pipeline.sh

This file automatically calls `01_download_data.sh` and then proceeds to iterate through all data in the data/raw/ directory, passing the
files to `02_run_fastp.sh` for analysis.

### Expected Output

After running `pipeline.sh` from assignment_05/, the data/trimmed/ directory should be populated with the trimmed data and the log/ directory
should contain one report for each unique sequence.

## Reflection

This assignment really helped me visualize what a pipeline in bash looks like. I have developed pipelines in Python before, but in this
setting, it is decidedly a little different. I again reformed some of my troubleshooting strategies and it reemphasized the importance of
testing each individual step of the pipeline first, and adding the automated portion last to avoid unneccessary headache. Splitting up the
two main steps of this pipeline into different scripts is extremely helpful in determining where the pipeline might be failing. For example,
I was getting an error with the report files trying to overwrite each other because it was making two reports for each sequence name. Had
the whole pipeline been in one file, I never would have been able to pinpoint where the error was coming from or, at the very least, do so
in an efficient manner. It is also useful because you can test each part individually whereas if everything was in a single script, you
wouldn't be able to call specific parts.
