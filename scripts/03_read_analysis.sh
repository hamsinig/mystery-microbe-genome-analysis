#!/bin/bash

set -euo pipefail

mkdir -p results/blast

# Summarize trimmed paired-end reads
seqkit stats results/trimmed/*_trimmed.fastq

# Randomly sample 1,000 reads from R1
seqkit sample \
    -n 1000 \
    -s 42 \
    results/trimmed/SRR2584863_1_trimmed.fastq \
    > results/blast/subset_1000.fastq

# Convert sampled reads from FASTQ to FASTA
seqkit fq2fa \
    results/blast/subset_1000.fastq \
    > results/blast/subset_1000.fasta

# Prepare individual query files for preliminary BLAST
seqkit head -n 10 results/blast/subset_1000.fasta \
    > results/blast/query_10.fasta

echo "Read statistics and BLAST query preparation completed."
