#!/bin/bash

set -euo pipefail

mkdir -p results/annotation

# Run Prokka using Docker (AMD64 image)
docker run --rm \
    --platform linux/amd64 \
    -v "$(pwd)/results/assembly:/input" \
    -v "$(pwd)/results/annotation:/output" \
    staphb/prokka:latest \
    prokka \
    --outdir /output \
    --prefix mystery_microbe \
    --locustag MYST \
    --kingdom Bacteria \
    --cpus 4 \
    --force \
    /input/contigs.fasta

echo "Genome annotation completed."
