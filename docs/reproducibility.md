# Reproducibility Guide

## Project Overview

This project characterizes an unknown bacterial genome using
Illumina paired-end sequencing data (SRA: SRR2584863).

The workflow includes quality control, read trimming, genome
assembly, annotation, species identification, and antimicrobial
resistance gene screening.

## Requirements

- Linux or macOS
- Conda environment with bioinformatics tools
- Docker
- Python 3
- Internet access for downloading sequencing data and references

Software versions are recorded in:
`config/software_versions.txt`

## Execution

All commands should be executed from the project root directory.

Run the workflow scripts in the following order:

1. `bash scripts/01_download_data.sh`
2. `bash scripts/02_quality_control.sh`
3. `bash scripts/03_read_analysis.sh`
4. `bash scripts/04_assembly.sh`
5. `python scripts/calculate_gc.py`
6. `python scripts/calculate_n50.py`
7. `bash scripts/05_annotation.sh`
8. `bash scripts/06_species_identification.sh`
9. `bash scripts/07_resistance_screening.sh`

These scripts document the original analysis. They do not need
to be rerun to inspect the results committed to this repository.

## Preliminary BLAST Identification

Ten sampled reads were investigated manually using NCBI BLASTn
against the nucleotide collection (nt).

The preliminary analysis suggested Escherichia coli, with
matches to other related bacterial sequences.

The BLAST investigation is documented in:
`docs/preliminary_blast_report.md`

BLAST queries are preserved under `results/blast/`.

The online BLAST search is not automated by the workflow scripts.

## Species Identification

Mash was used to identify closely related reference genomes.

FastANI was subsequently used to compare the assembly against
Escherichia coli and Shigella flexneri references.

Results:

- E. coli ANI: 98.9929%
- Shigella flexneri ANI: 97.6224%

These results support an E. coli-like genome but do not
establish an exact strain identity.

## Antimicrobial Resistance Screening

RGI 6.0.8 was run against CARD 4.0.2 using predicted
protein sequences from Prokka.

The analysis identified:

- 22 Perfect hits
- 32 Strict hits
- 54 total hits

These are computational predictions, not experimental
measurements of antibiotic susceptibility.

The workflow uses CARD's latest-download endpoint, which
may return a newer database release in future runs.

## Reproducibility Limitations

- The Mash reference database uses a latest-release URL.
- The CARD download URL is not version-pinned.
- The Prokka Docker image uses the latest tag.
- BLASTn was performed manually through the NCBI website.
- Software and database updates may change future results.
- The scripts assume execution from the repository root.
- Some existing output directories may need to be removed
  before rerunning tools that require fresh output locations.

## Data Availability

Original sequencing reads can be obtained from NCBI SRA
using accession SRR2584863.

Raw sequencing files and large reference databases are
excluded from GitHub to keep the repository manageable.
