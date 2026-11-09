# Bacterial Genome Characterization & AMR Screening

A bioinformatics project exploring bacterial genome identification and antimicrobial resistance-associated genes using whole-genome sequencing data.

## Project Overview

This project implements an end-to-end bacterial genome analysis workflow, starting from raw paired-end sequencing reads and progressing through quality control, genome assembly, annotation, taxonomic identification, and antimicrobial resistance (AMR) screening.

**Dataset:** NCBI SRA — [SRR2584863](https://www.ncbi.nlm.nih.gov/sra/?term=SRR2584863)

## Workflow

```text
Raw paired-end reads
        |
        v
   FastQC
        |
        v
  fastp trimming
        |
        v
   SPAdes assembly
        |
        v
   Prokka annotation
        |
        +----------------------+
        |                      |
        v                      v
 Mash / FastANI             CARD / RGI
        |                      |
        v                      v
 Taxonomic identity       AMR screening
```

## Key Results

| Analysis | Result |
|---|---|
| Assembly size | 4,570,121 bp |
| Number of contigs | 159 |
| N50 | 153,581 bp |
| GC content | 50.74% |
| Predicted CDS | 4,261 |
| *E. coli* ANI | 98.9929% |
| CARD/RGI hits | 54 |

The taxonomic comparisons support an *E. coli*-like genome. The AMR screening identified 54 Perfect and Strict resistance-associated hits.

**Note:** These are computational predictions, not experimentally confirmed antibiotic resistance results.

## Tools & Technologies

- **Read processing:** SRA Toolkit, FastQC, fastp, SeqKit
- **Genome assembly:** SPAdes
- **Genome annotation:** Prokka
- **Taxonomic identification:** BLAST, Mash, FastANI
- **AMR screening:** CARD, RGI, DIAMOND
- **Environment:** Conda, Docker, Python, macOS

## Repository Structure

```text
mystery_microbe/
├── README.md
├── docs/
│   └── project_report.md
├── scripts/
├── config/
├── environment/
├── data/          # Raw data and reference databases excluded
├── results/       # Selected analysis outputs
├── .gitignore
└── LICENSE
```

## Documentation

For the complete scientific methodology, results, discussion, limitations, and references, see:

[**Full Project Report**](docs/project_report.md)

## Reproducibility

The original sequencing data can be retrieved using SRA accession `SRR2584863`.

Raw sequencing files and large reference databases are excluded from this repository. Scripts and configuration files will document the analysis workflow and software requirements.

## Limitations

- The genome is a draft assembly, not a complete closed genome.
- Taxonomic identification is based on comparisons with selected reference genomes.
- AMR predictions are database-dependent and based on protein homology screening.
- Phenotypic antimicrobial susceptibility was not experimentally tested.

## Author

Bioinformatics | Computational Genomics | Bacterial Genome Analysis

