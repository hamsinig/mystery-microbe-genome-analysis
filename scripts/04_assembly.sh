#!/bin/bash

set -euo pipefail

mkdir -p results/assembly

# Assemble paired-end reads using SPAdes
spades.py \
    -1 results/trimmed/SRR2584863_1_trimmed.fastq \
    -2 results/trimmed/SRR2584863_2_trimmed.fastq \
    -o results/assembly \
    -t 4 \
    -m 8

echo "Genome assembly completed."
