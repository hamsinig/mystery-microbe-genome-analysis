#!/bin/bash

set -euo pipefail

mkdir -p data/references/card data/references/card/rgi_local
mkdir -p results/resistance

# Download CARD database
curl -L \
    https://card.mcmaster.ca/latest/data \
    -o data/references/card/card_data.tar.bz2

# Extract CARD database
tar -xjf data/references/card/card_data.tar.bz2 \
    -C data/references/card

# Load CARD into RGI local database
docker run --rm \
    --platform linux/amd64 \
    -v "$(pwd)/data/references/card:/card" \
    -v "$(pwd)/data/references/card/rgi_local:/localDB" \
    quay.io/biocontainers/rgi:6.0.8--pyh05cac1d_0 \
    rgi load --local -i /card/card.json

# Screen predicted proteins against CARD
docker run --rm \
    --platform linux/amd64 \
    -v "$(pwd)/results/annotation:/annotation" \
    -v "$(pwd)/results/resistance:/output" \
    -v "$(pwd)/data/references/card/rgi_local:/localDB" \
    quay.io/biocontainers/rgi:6.0.8--pyh05cac1d_0 \
    rgi main \
    --input_sequence /annotation/mystery_microbe.faa \
    --output_file /output/mystery_microbe_proteins \
    --input_type protein \
    --alignment_tool DIAMOND \
    --threads 4 \
    --local \
    --clean

echo "CARD resistance screening completed."
