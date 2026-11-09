# Bacterial Genome Characterization and Antimicrobial Resistance Screening

## 1. Abstract

This project presents a bioinformatics workflow for the characterization of an unknown bacterial genome using publicly available whole-genome sequencing data. The workflow includes sequencing quality assessment, read trimming, de novo genome assembly, genome annotation, taxonomic identification, and antimicrobial resistance (AMR) gene screening.

Paired-end sequencing reads associated with SRA accession **SRR2584863** were processed using FastQC and fastp. The quality-filtered reads were assembled using SPAdes, and the resulting genome assembly was annotated using Prokka. Mash and FastANI were used for preliminary taxonomic identification, while Resistance Gene Identifier (RGI) was used with the Comprehensive Antibiotic Resistance Database (CARD) to identify resistance-associated genes.

The assembly contained 159 contigs, with a total length of 4,570,121 bp and an N50 of 153,581 bp. Comparison against reference genomes produced an average nucleotide identity (ANI) of 98.9929% against an *Escherichia coli* reference genome. RGI identified 54 resistance-associated hits, comprising 22 Perfect and 32 Strict hits.

These findings support the characterization of the sample as an *E. coli*-like genome and demonstrate how computational genomics tools can be combined to investigate bacterial identity and potential antimicrobial resistance determinants.

## 2. Introduction

Bacterial genome sequencing provides an opportunity to study microbial identity, genetic composition, and antimicrobial resistance at the genomic level.

Whole-genome sequencing (WGS) generates large quantities of DNA sequence data. Bioinformatics tools are required to process these reads, reconstruct the genome, identify genes, and compare the resulting sequences with reference databases.

Antimicrobial resistance is an important concern in public health. Bacteria may acquire or develop genetic mechanisms that reduce susceptibility to antibiotics. Genome-based screening can identify known resistance-associated genes and mutations, although computational predictions alone cannot establish an organism's actual antibiotic susceptibility.

This project applies a computational workflow to an unknown bacterial sequencing dataset, with two primary goals:

1. Characterize the bacterial genome and investigate its taxonomic identity.
2. Identify known antimicrobial resistance-associated genes using CARD.

## 3. Dataset Description

The dataset was obtained from the NCBI Sequence Read Archive (SRA).

| Parameter | Description |
|---|---|
| SRA accession | SRR2584863 |
| Sequencing data | Paired-end reads |
| Original read length | 150 bp |
| Original reads (R1) | 1,553,259 |
| Original reads (R2) | 1,553,259 |
| Total individual reads | 3,106,518 |
| Total bases | 465,977,700 |

The sequencing data were downloaded using SRA Toolkit.

The paired-end reads were stored as separate FASTQ files, representing the forward and reverse reads.

## 4. Methodology

### 4.1 Read Quality Assessment

FastQC was used to evaluate the quality of the raw sequencing reads.

The quality assessment included:

- Per-base sequence quality
- Per-sequence quality scores
- Per-base sequence composition
- GC content distribution
- Adapter content
- Sequence duplication levels

The initial quality assessment indicated generally good sequencing quality.

Some warnings were observed:

- Base composition imbalance in approximately the first nine bases.
- Slight deviation in the GC distribution.
- Increasing adapter content towards the ends of reads, consistent with a Nextera adapter signal.

These observations motivated adapter trimming and quality filtering before assembly.

### 4.2 Read Trimming and Filtering

The paired-end reads were processed using fastp.

The following parameters were used:

- Minimum quality threshold: Q20
- Minimum read length: 100 bp
- Automatic adapter detection for paired-end reads
- Four processing threads

The objective was to remove adapter contamination and low-quality portions of the reads while retaining sufficiently long, high-quality sequences.

**Post-trimming statistics:**

| Parameter | Result |
|---|---:|
| Retained individual reads | 2,398,740 |
| Retained read pairs | 1,199,370 |
| Total retained bases | 356,341,694 |
| Q20 bases | 96.32% |
| Q30 bases | 89.18% |
| Mean read length | Approximately 148.6 bp |

The results indicate that the filtering process retained a substantial quantity of high-quality sequencing data.

### 4.3 Preliminary Sequence Identification Using BLAST

A subset of 1,000 forward reads was sampled from the trimmed dataset. Ten reads were subsequently selected for preliminary BLAST searches against the NCBI nucleotide database.

The observed matches were predominantly associated with *Escherichia coli* and *Shigella*, with several matches showing high sequence identity and coverage.

This provided an initial indication of the organism's possible taxonomic identity.

However, a small number of reads cannot reliably establish the identity of an entire genome. Therefore, whole-assembly comparisons were performed in subsequent stages.

### 4.4 De Novo Genome Assembly

The quality-filtered paired-end reads were assembled using SPAdes.

De novo assembly reconstructs longer genomic sequences, known as contigs, from overlapping sequencing reads without requiring a complete reference genome.

The following assembly statistics were obtained:

| Metric | Result |
|---|---:|
| Number of contigs | 159 |
| Total assembly length | 4,570,121 bp |
| Minimum contig length | 78 bp |
| Maximum contig length | 348,112 bp |
| Average contig length | 28,742.9 bp |
| N50 | 153,581 bp |
| GC content | 50.74% |

The N50 value indicates that contigs of 153,581 bp or longer account for at least half of the total assembly length.

The assembly represents a draft genome rather than a complete, closed chromosome.

### 4.5 Genome Annotation Using Prokka

The assembled contigs were annotated using Prokka.

Genome annotation identifies potential genomic features, including protein-coding sequences and RNA genes.

The annotation produced the following results:

| Feature | Count |
|---|---:|
| Contigs | 159 |
| Total bases | 4,570,121 |
| Protein-coding sequences (CDS) | 4,261 |
| rRNA genes | 7 |
| tRNA genes | 92 |
| tmRNA genes | 1 |
| Repeat regions | 2 |
| Hypothetical proteins | 695 |

Approximately 16.31% of the predicted CDS were annotated as hypothetical proteins.

Hypothetical proteins are predicted protein-coding sequences for which a sufficiently confident functional annotation was not assigned.

The annotation provided predicted protein sequences, nucleotide sequences, and feature files that were used in subsequent analyses.

### 4.6 Taxonomic Identification

Taxonomic identification was performed using Mash and FastANI.

#### Mash

Mash estimates genomic similarity using MinHash sketches, which provide a computationally efficient way to compare large DNA sequences.

The assembled genome was compared against a RefSeq sketch database containing 22,274 reference sketches.

The closest matches included:

| Reference organism | Mash distance |
|---|---:|
| *Escherichia coli* | 0.00948708 |
| *Shigella boydii* | 0.0162749 |
| *Shigella sonnei* | 0.0173006 |
| *Shigella flexneri* | 0.0210181 |
| *Shigella dysenteriae* | 0.0212923 |

The lowest Mash distance was observed against an *E. coli* reference genome.

#### FastANI

FastANI was used to perform a more direct genome-wide average nucleotide identity comparison.

The assembly was compared against reference genomes for *E. coli* and *Shigella flexneri*.

| Reference genome | ANI | Matched fragments |
|---|---:|---:|
| *E. coli* | 98.9929% | 1,393 / 1,484 |
| *Shigella flexneri* | 97.6224% | 1,277 / 1,484 |

The highest ANI was observed against the *E. coli* reference genome.

ANI values around 95–96% are commonly used as an approximate species-level boundary. However, *E. coli* and *Shigella* are exceptionally closely related, and their taxonomic distinction can be complex.

Therefore, the strongest result from these comparisons is that the sample is an *E. coli*-like genome. The exact strain and its definitive taxonomic classification have not been established.

### 4.7 Antimicrobial Resistance Screening

Antimicrobial resistance-associated genes were screened using the Resistance Gene Identifier (RGI) tool and the Comprehensive Antibiotic Resistance Database (CARD).

The Prokka-predicted protein sequences were supplied to RGI in protein input mode, using DIAMOND as the alignment tool and a locally loaded CARD database.

The protein-based approach was used after an initial contig-mode attempt encountered a sequence identifier mismatch.

RGI identified:

| Hit classification | Count |
|---|---:|
| Perfect | 22 |
| Strict | 32 |
| Total | 54 |

The 54 hits corresponded to 54 unique Best_Hit_ARO entries in the output.

The reported resistance mechanisms included:

| Resistance mechanism | Number of hits |
|---|---:|
| Antibiotic efflux | 43 |
| Antibiotic target alteration | 14 |
| Reduced permeability | 2 |
| Antibiotic inactivation | 1 |

These mechanism counts are non-exclusive and can overlap across the detected hits.

The output also contained associations with several antibiotic classes, including fluoroquinolones, tetracyclines, beta-lactams, macrolides, and cephalosporins.

Examples of identified resistance-associated gene or model names included acrB, acrD, acrF, emrA, emrB, and eptA.

These findings indicate the presence of multiple known resistance-associated genetic determinants or homologues in the predicted protein set.

## 5. Results and Discussion

The analysis produced three main findings.

**5.1 Genome characteristics**

The assembly had a total length of approximately 4.57 Mb and a GC content of 50.74%. The 159-contig assembly and N50 of 153,581 bp provide a draft representation of the bacterial genome.

**5.2 Taxonomic identification**

Mash and FastANI independently supported an *E. coli*-like identification. The ANI against the selected *E. coli* reference was 98.9929%, compared with 97.6224% against the selected *Shigella flexneri* reference.

The results favour the *E. coli* reference among the genomes tested. They do not establish the exact strain.

**5.3 Antimicrobial resistance-associated genes**

RGI identified 54 Perfect and Strict hits. Antibiotic efflux was the most frequently represented resistance mechanism in the reported output.

The presence of these genes provides useful genomic evidence for further investigation of potential antimicrobial resistance.

However, the number of detected hits should not be interpreted as the number of antibiotics to which the organism is resistant.

## 6. Limitations

Several limitations should be considered when interpreting the results.

1. **Draft assembly:** The genome was assembled into 159 contigs and was not resolved into a complete chromosome.

2. **Reference-dependent identification:** Taxonomic identification depends on the reference genomes and databases used. The comparisons performed do not establish an exact strain.

3. **Closely related taxa:** The close evolutionary relationship between *E. coli* and *Shigella* makes definitive classification more challenging.

4. **Protein-based AMR screening:** RGI was run on predicted proteins. This approach does not provide a complete assessment of all nucleotide-level or SNP-dependent resistance determinants.

5. **Database-dependent predictions:** AMR screening depends on the CARD database version and the models available at the time of analysis.

6. **No phenotypic susceptibility testing:** Computational detection of resistance-associated genes does not establish clinical resistance. Laboratory antimicrobial susceptibility testing would be required to determine the organism's actual susceptibility profile.

7. **No strain-level validation:** Additional analyses, such as multilocus sequence typing or other strain-typing approaches, would be needed for more specific characterization.

## 7. Conclusion

This project demonstrates an end-to-end bacterial genome characterization workflow using publicly available whole-genome sequencing data.

The workflow covered sequencing quality assessment, read trimming, de novo assembly, genome annotation, taxonomic comparison, and antimicrobial resistance-associated gene screening.

The assembled genome showed strong similarity to an *E. coli* reference genome, with an ANI of 98.9929%. The annotation identified 4,261 protein-coding sequences, while CARD/RGI screening detected 54 Perfect and Strict resistance-associated hits.

Overall, the project demonstrates how computational genomics tools can be integrated to investigate bacterial identity and potential antimicrobial resistance determinants. It also highlights the importance of interpreting computational predictions carefully and distinguishing genomic evidence from experimentally confirmed phenotypes.

## 8. Tools and Software

| Tool | Purpose |
|---|---|
| SRA Toolkit | Downloading sequencing data |
| FastQC | Read quality assessment |
| fastp | Adapter trimming and quality filtering |
| SeqKit | FASTQ/FASTA processing |
| BLAST | Preliminary sequence similarity search |
| SPAdes 4.3.0 | De novo genome assembly |
| Prokka 1.15.6 | Genome annotation |
| Mash 2.3 | Genome similarity estimation |
| FastANI 1.34 | Average nucleotide identity comparison |
| RGI 6.0.8 | AMR gene screening |
| CARD 4.0.2 | AMR reference database |
| Docker | Running containerized tools |

## 9. Reproducibility

The project was performed using a Conda environment on macOS with an Apple Silicon processor. Docker was used with AMD64 platform emulation for Prokka and RGI.

The raw sequencing reads and reference databases are not included in the GitHub repository because of their size. The accession number SRR2584863 can be used to retrieve the original sequencing data.

The repository's scripts, configuration files, software versions, and selected results should be used alongside this report to reproduce the workflow.

## 10. References

1. National Center for Biotechnology Information. Sequence Read Archive (SRA). https://www.ncbi.nlm.nih.gov/sra/

2. Andrews, S. FastQC: A Quality Control Tool for High Throughput Sequence Data. https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

3. Chen, S. et al. fastp: an ultra-fast all-in-one FASTQ preprocessor. *Bioinformatics* (2018). https://doi.org/10.1093/bioinformatics/bty560

4. Prjibelski, A. et al. Using SPAdes De Novo Assembler. *Current Protocols in Bioinformatics* (2020). https://doi.org/10.1002/cpbi.102

5. Seemann, T. Prokka: rapid prokaryotic genome annotation. *Bioinformatics* (2014). https://doi.org/10.1093/bioinformatics/btu153

6. Ondov, B. D. et al. Mash: fast genome and metagenome distance estimation using MinHash. *Genome Biology* (2016). https://doi.org/10.1186/s13059-016-0997-x

7. Jain, C. et al. High throughput ANI analysis of 90K prokaryotic genomes reveals clear species boundaries. *Nature Communications* (2018). https://doi.org/10.1038/s41467-018-07641-9

8. Alcock, B. P. et al. CARD 2023: expanded curation, support for machine learning, and resistome prediction at the Comprehensive Antibiotic Resistance Database. *Nucleic Acids Research* (2023). https://doi.org/10.1093/nar/gkac920

9. Jia, B. et al. CARD 2017: expansion and model-centric curation of the Comprehensive Antibiotic Resistance Database. *Nucleic Acids Research* (2017). https://doi.org/10.1093/nar/gkw1004
