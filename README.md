# Bacterial Genome Characterization & Antimicrobial Resistance Screening

A computational genomics project investigating an unknown bacterial genome using whole-genome sequencing data.

## Project Overview

This project implements a bacterial genome analysis workflow, starting with raw Illumina paired-end sequencing reads and progressing through quality control, genome assembly, annotation, taxonomic identification, and antimicrobial resistance (AMR) gene screening.

**Dataset:** [NCBI SRA — SRR2584863](https://www.ncbi.nlm.nih.gov/sra/?term=SRR2584863)

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
  SeqKit statistics
        |
        v
  SPAdes assembly
        |
        v
  Assembly statistics
        |
        v
  Prokka annotation
        |
        +-----------------------+
        |                       |
        v                       v
  Mash / FastANI            CARD / RGI
        |                       |
        v                       v
 Species identification     AMR screening
```

A preliminary BLASTn investigation was also performed using sampled sequencing reads.

## Key Results

| Analysis | Result |
|---|---:|
| Original read pairs | 1,553,259 |
| Read pairs after trimming | 1,199,370 |
| Assembly size | 4,570,121 bp |
| Number of contigs | 159 |
| N50 | 153,581 bp |
| GC content | 50.74% |
| Predicted CDS | 4,261 |
| *E. coli* ANI | 98.9929% |
| *Shigella flexneri* ANI | 97.6224% |
| AMR Perfect hits | 22 |
| AMR Strict hits | 32 |
| Total AMR hits | 54 |

### Species Identification

Mash and FastANI comparisons support an *Escherichia coli*-like genome. The comparison against *Shigella flexneri* also showed high sequence similarity, reflecting the close relationship between these organisms.

An exact strain identity was not established.

### Antimicrobial Resistance Screening

Protein sequences predicted by Prokka were screened against CARD using RGI and DIAMOND.

The analysis identified 54 resistance-associated hits:
- 22 Perfect
- 32 Strict

These represent computational database matches, not experimentally confirmed antibiotic resistance.

## Tools & Technologies

- **Data acquisition:** NCBI SRA Toolkit
- **Quality control:** FastQC, fastp
- **Read statistics:** SeqKit
- **Genome assembly:** SPAdes
- **Assembly statistics:** Python
- **Genome annotation:** Prokka
- **Taxonomic identification:** BLASTn, Mash, FastANI
- **AMR screening:** CARD, RGI, DIAMOND
- **Environment:** Conda, Docker, Python

## Repository Structure

```text
mystery_microbe/
├── README.md
├── docs/
│   ├── project_report.md
│   ├── preliminary_blast_report.md
│   └── reproducibility.md
├── scripts/
│   ├── 01_download_data.sh
│   ├── 02_quality_control.sh
│   ├── 03_read_analysis.sh
│   ├── 04_assembly.sh
│   ├── 05_annotation.sh
│   ├── 06_species_identification.sh
│   ├── 07_resistance_screening.sh
│   ├── calculate_gc.py
│   └── calculate_n50.py
├── config/
│   └── software_versions.txt
├── data/              # Raw data and reference databases excluded
├── results/
│   ├── qc/
│   ├── trimmed/
│   ├── blast/
│   ├── assembly/
│   ├── annotation/
│   └── resistance/
├── .gitignore
└── LICENSE
```

## Documentation

- [Full Project Report](docs/project_report.md)
- [Preliminary BLAST Report](docs/preliminary_blast_report.md)
- [Reproducibility Guide](docs/reproducibility.md)
- [Software Versions](config/software_versions.txt)

## Reproducibility

The workflow scripts document the commands used throughout the analysis.

To reproduce the analysis, retrieve the original sequencing data using accession `SRR2584863` and follow the execution instructions in the reproducibility guide.

Raw sequencing files and large reference databases are excluded from GitHub to keep the repository manageable.

Some external databases use latest-release download URLs, so future runs may produce different results.

## Limitations

- The genome is a draft assembly, not a complete closed genome.
- Taxonomic identification relies on comparisons with selected reference genomes.
- AMR screening is database-dependent and based on computational protein homology.
- Phenotypic antimicrobial susceptibility was not experimentally tested.
- The preliminary BLAST investigation used only ten sampled reads.

## Author

Bioinformatics | Computational Genomics | Bacterial Genome Analysis
