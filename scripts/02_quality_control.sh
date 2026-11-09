#!/bin/bash

set -euo pipefail

mkdir -p results/qc results/qc/trimmed results/trimmed

# Quality check raw reads
fastqc \
    data/raw/SRR2584863_1.fastq \
    data/raw/SRR2584863_2.fastq \
    --outdir results/qc

# Trim adapters and low-quality reads
fastp \
    -i data/raw/SRR2584863_1.fastq \
    -I data/raw/SRR2584863_2.fastq \
    -o results/trimmed/SRR2584863_1_trimmed.fastq \
    -O results/trimmed/SRR2584863_2_trimmed.fastq \
    --qualified_quality_phred 20 \
    --length_required 100 \
    --detect_adapter_for_pe \
    --thread 4 \
    --html results/trimmed/fastp_report.html \
    --json results/trimmed/fastp_report.json

# Quality check trimmed reads
fastqc \
    results/trimmed/SRR2584863_1_trimmed.fastq \
    results/trimmed/SRR2584863_2_trimmed.fastq \
    --outdir results/qc/trimmed

echo "Quality control and trimming completed."

