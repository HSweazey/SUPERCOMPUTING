# Supercomputing Assignment 4
**Name:** Hannah Sweazey

**Due Date:** February 26, 2026

In this assignment, we were tasked with: 
- Building bash scripts to automate software/tool installation
- Building a bash script to summarize fasta file contents
- Use loops to do iterative analysis
- Documenting our work in a clean and professional fashion

Directory structure at the end of assignment 4:
```text
assignment_04/
├── README.md
├── summarize_fasta.sh
└── data/
    ├─ GCF_000001735.4_TAIR10.1_genomic.fna
    ├─ GCF_000001735.4_TAIR10.1_genomic.copy.fna
    └─ newbloom.all.fna
```
## Bash Script for gh Installation

*Assuming this is being run from the projects directory*

```bash
#!/bin/bash
set -ueo pipefail

wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz
tar -xzvf gh_2.74.2_linux_amd64.tar.gz
rm gh_2.74.2_linux_amd64.tar.gz

```

Our programs directory was already added to our $PATH, but in the interest of comprehnsiveness I have included the line:

```bash
PATH=$PATH:/sciclone/home/hrsweazey/programs
```

## Bash Script for seqtk Installation

*Assuming this script is created in the programs directory*

```bash
#!/bin/bash
set -ueo pipefail

git clone https://github.com/lh3/seqtk.git;
cd seqtk; make
echo 'export PATH=$PATH:/sciclone/home/hrsweazey/programs/seqtk' >> ~/.bashrc

```
I called source ~/.bashrc to check that the PATH was added successfully.

## Bash Script for Summarizing fasta Files

Firstly, I read up on the seqtk documentation to see what commands are most used, what they do, and how to call them.
I then naviagted to my assignment_04 to build the following script.

```bash
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
```

## Looping Through fasta Files

I downloaded an additonal fasta from a random GitHub repo and made two copies of Assignment 3's data file.
I also added assignments/assignment_04/data to the .gitignore

*Assuming this command is being run from the assignment_04 directory*

```bash
for file in data/*.fna; do bash summarize_fasta.sh ${file}; done
```

## Reflection
The biggest challenge I faced in this assignment was figuring out how to troubleshoot by bash scripts. It was a pain to write a
script, save and exit, run it, interpret any errors, enter back into the script, and repeat. I quickly found it was easiest to
track my file on a document outside of my terminal and run the lines one by one to ensure they worked before compiling all the
steps into a bash script. I also found it challenging to understand what the {} must be used to protect a variable, but upon
reflection, I don't think there was a time in which I didn't use {}. I also had trouble finding fasta files which was likely due to
my unfamiliarity with the domain. Outside of these issues, I find creating bash scripts generally intuitive.

I think the biggest thing I learned during this assignment was just about the general workings of bash scripts and troubleshooting.
It is quite different from coding in python, which is what I'm used to, so getting more practice within the terminal and applying
the more recent concepts we've covered in class was very helpful. There's a lot you can do in the terminal that I wouldn't have
thought (given its age), but because it does not present as human-readable as python, it seemed more inaccessible.

After utilizing it during this assignment, I've learned a few things about what $PATH is. At surface level, it is a variable.
Looking deeper, it allows a user to define their own 'path,' or rather, define directories that can be accessed from any level
in the machine. This is was important when using seqtk. Since I was using it within my assignment_04 directory, the path to where
the seqtk tool was located needed to be included in my $PATH defintion so that I could access it outside of its physical location.
