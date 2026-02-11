# Supercomputing Assignment 2
Name: Hannah Sweazey
Due Date: February 12, 2026

In this assignment, we were tasked with: 
- Using ftp to download files
- Using FireZilla to transfer files to the HPC
- Changing file permissions in HPC
- Using md5 hashes to verify file integrity
- Interpreting shell commands

Directory structure at the end of assignment 2:
```text
assignment_02/
├── README.md
└── data/
    ├── GCF_000005845.2_ASM584v2_genomic.fna.gz
    └── GCF_000005845.2_ASM584v2_genomic.gff.gz
```
## Commands for Task 2

```python
ftp ftp.ncbi.nlm.nih.gov
login credentials (anonymous, email)
passive
cd genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/
ls
mget GCF_000005845.2_ASM584v2_genomic.fna.gz
mget GCF_000005845.2_ASM584v2_genomic.gff.gz
bye
```

## Workflow for Task 3

- Open FireZilla
- Connect to bora using HPC credentials
- Navigate to home directory on local machine (where files were downloaded to from NCBI)
- Navigate to assignment_02/data on bora
- Drag and drop files into HPC folder
- Log on to HPC and make files readable using below commands

```python
cd SUPERCOMPUTING
cd assignments
cd assignment_02
cd data
chmod 644 GCF_000005845.2_ASM584v2_genomic.fna.gz
chmod 644 GCF_000005845.2_ASM584v2_genomic.gff.gz
```

## Commands for Task 4

```python
# HPC hash integrity check

md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz 
e1b894042b53655594a1623a7e0bb63f  GCF_000005845.2_ASM584v2_genomic.fna.gz

md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz 
494dc5999874e584134da5818ffac925  GCF_000005845.2_ASM584v2_genomic.gff.gz
```
```python
# Local machine hash integrity check

md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz 
e1b894042b53655594a1623a7e0bb63f  GCF_000005845.2_ASM584v2_genomic.fna.gz

md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz 
494dc5999874e584134da5818ffac925  GCF_000005845.2_ASM584v2_genomic.gff.gz
# the returned hashes match
```

## Descriptions for Task 5

```python
# moves to the parent directory, clears the terminal, prints working directory, 
# and prints contents with folders coming first
alias u='cd ..;clear;pwd;ls -alFh --group-directories-first'

# moves to last working directory, clears terminal, prints working directory, 
# and prints contents with folders coming first
alias d='cd -;clear;pwd;ls -alFh --group-directories-first'

# lists all directory contents in long, human-readable format
alias ll='ls -alFh --group-directories-first'
```

## Reflection

Overall, I enjoyed this assignment because it is easier for me to process what I
learn by applying it. The major challenge I faced was letting my computer 
communicate with the NCBI FTP server since it seems that Macs' firewalls make
this process a bit harder. Once I discovered the passive command, however, I was
able to use the ftp server and the commands as we did in class. I generally 
thought this assignment went well and feel confident I can reproduce it.
