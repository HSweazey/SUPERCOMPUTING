# Supercomputing Assignment 3
**Name:** Hannah Sweazey

**Due Date:** February 18, 2026

In this assignment, we were tasked with: 
- Using and manipulating stdins and stdouts to get info from genomic data
- Using grep, wc, cat, and other commands on file data
- Documenting our work in a clean and professional fashion

Directory structure at the end of assignment 3:
```text
assignment_03/
├── README.md
└── data/
    ├─ GCF_000001735.4_TAIR10.1_genomic.fna
    └─ tab.txt
```
## Commands for Task 2

```bash
cd assignments/assignments_03

wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz
mv GCF_000001735.4_TAIR101.1_genomic/fna.gz data
gunzip data/GCF_000001735.4_TAIR101.1_genomic/fna.gz
```

## Commands for Task 3

```bash
echo "#1: Number of sequences"
grep -c "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna

echo "#2: Number of nucleotides"
grep -v "^[>,\n]" data/GCF_000001735.4_TAIR10.1_genomic.fna |tr -d "\n" |wc -c

echo "#3: Number of lines"
wc -l data/GCF_000001735.4_TAIR10.1_genomic.fna

echo "#4: Header lines with 'mitochondrion'"
grep -c -i "mitochondrion" data/GCF_000001735.4_TAIR10.1_genomic.fna

echo "#5: Header lines with 'chromosome'"
grep -c -i "chromosome" data/GCF_000001735.4_TAIR10.1_genomic.fna

echo "#6: Nucleotides in first 3 sequences"
grep -v "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna |head -n 1|wc -c
grep -v "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna |head -n 2|tail -n 1|wc -c
grep -v "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna |head -n 3|tail -n 1| wc -c

echo "#7: Nucleotides in 'chromosome 5'"
grep -n -i "chromosome 5" data/GCF_000001735.4_TAIR10.1_genomic.fna 
head -n 10 data/GCF_000001735.4_TAIR10.1_genomic.fna | tail -n 1 | wc -c

echo "#8: AAAAAAAAAAAAAAAA"
grep "AAAAAAAAAAAAAAAA" data/GCF_000001735.4_TAIR10.1_genomic.fna|wc -l

echo "#10: Tab-separated file"
paste -d "\t"  <(grep "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna) <(grep -v "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna)> data/tab.txt
```

## Reflection
My approach to this assignment was to mimic the strategies we used in class. Using grep and redirecting output feels very
much like solving a puzzle; I know all the pieces have been given to me, it's just a question of where they go. I referred
to my notes a lot as well as the practice assignment for help. Even if we hadn't done the exact task required, we had done
bits and pieces of it throughout Lesson 3. My goal was to hopefully synthesize all I had learned and have enough of an
understanding of how grep works to be able to efficiently problem-solve.

I think the biggest challenge/frustration was simply not knowing all the grep flags. There are so many tools available to me
that I simply didn't know or about or think to check for. For example, Challenge #7 took the longest for me simply because I
did not know grep had the -n flag to return the line number. It also took me a second to realize you can group multiple flags
when using grep which makes life significantly easier. Other than simply my lack of familiarity and knowledge, it is a
fairly intuitive system and makes data analysis (at least with this type of data) easier than other methods.

I can see how this skills would be imparative for computational work. It is less human-readable, but the efficiency of 
using grep as opposed to other data science libraries such as pandas was surprising. Since a lot of dealing with data is
the preliminary inspection and cleaning, harnessing these skills in this manner becomes even more important. It is also
important to be reminded that even though there are an infinite number of tools and strategies out there for dealing with
data, sometimes less is more. A simpler tool, like using grep and other shell commands, I'm guessing is more effective
than a majority of other approaches out there.\

In terms of automation, I definitely think there is merit in integrating some sort of data cleaning and summary pipeline.
If I knew I would need to do these same 10 steps each time I got a new file of this type/format, I would very quickly
seek out some way to automate the process. Writing the code is half the battle and I'm not well-versed in how automation
pipeline works in the terminal, but it's something worth troubleshooting and implementing.
