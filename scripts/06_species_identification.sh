#!/bin/bash

set -euo pipefail

mkdir -p results/assembly data/references/fastani

# Generate Mash sketch of assembled genome
mash sketch \
    -o results/assembly/mystery_microbe \
    results/assembly/contigs.fasta

# Download RefSeq Mash sketches
curl -L \
    https://zenodo.org/records/20293962/files/RefSeqSketches_latest.msh.gz \
    -o data/references/RefSeqSketches_latest.msh.gz

gzip -dk data/references/RefSeqSketches_latest.msh.gz

# Compare against RefSeq and save the top 10 matches
mash dist \
    data/references/RefSeqSketches_latest.msh \
    results/assembly/mystery_microbe.msh \
    | sort -g -k3,3 \
    | sed -n '1,10p' \
    > results/assembly/mash_top10.txt

# Download E. coli reference genome
curl -L \
    https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz \
    -o data/references/fastani/ecoli_reference.fna.gz

gunzip -k data/references/fastani/ecoli_reference.fna.gz

# Compare assembly against E. coli
fastANI \
    -q results/assembly/contigs.fasta \
    -r data/references/fastani/ecoli_reference.fna \
    -o results/assembly/ani_ecoli.txt

# Download Shigella flexneri reference genome
curl -L \
    https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/006/925/GCF_000006925.2_ASM692v2/GCF_000006925.2_ASM692v2_genomic.fna.gz \
    -o data/references/fastani/shigella_flexneri.fna.gz

gunzip -k data/references/fastani/shigella_flexneri.fna.gz

# Compare assembly against Shigella flexneri
fastANI \
    -q results/assembly/contigs.fasta \
    -r data/references/fastani/shigella_flexneri.fna \
    -o results/assembly/ani_shigella.txt

echo "Species identification completed."
