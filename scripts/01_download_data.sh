#!/bin/bash

set -euo pipefail

# Download sequencing data from NCBI SRA
mkdir -p data/sra data/raw

prefetch SRR2584863 -O data/sra

# Convert SRA to paired-end FASTQ files
fasterq-dump data/sra/SRR2584863/SRR2584863.sra \
    --split-files \
    -O data/raw \
    -e 4

echo "Data download and extraction completed."
