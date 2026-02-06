# Nextflow Pipeline for Genomic Variant Analysis

A modular Nextflow pipeline for processing sequencing data, from raw FASTQ files to variant calling. This pipeline performs quality control, read alignment, and variant detection in an automated and reproducible manner.

---

## Table of Contents

- [Introduction](#introduction)
- [What is Nextflow?](#what-is-nextflow)
- [Pipeline Overview](#pipeline-overview)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Environment Setup](#environment-setup)
- [Usage](#usage)
- [Pipeline Modules](#pipeline-modules)
- [Output](#output)
- [Git Operations](#git-operations)

---

## Introduction

This pipeline automates the analysis of next-generation sequencing (NGS) data. It integrates multiple bioinformatics tools to process raw sequencing reads through quality control, trimming, alignment, and variant calling steps.

**Key Features:**
- Modular architecture for easy customization
- Automated quality control with FastQC and MultiQC
- Read trimming and filtering
- Alignment to reference genome
- Variant calling and annotation
- Conda environment management for reproducibility

---

## What is Nextflow?

**Nextflow** is a workflow management system that enables scalable and reproducible scientific workflows. It allows you to write data-driven computational pipelines using a high-level declarative language.

### Why Nextflow?

- **Portability**: Run on local machines, HPC clusters, or cloud platforms
- **Scalability**: Automatically parallelizes tasks
- **Reproducibility**: Version control for workflows and dependencies
- **Container Support**: Works with Docker, Singularity, and Conda
- **Resume Capability**: Continue failed runs without reprocessing completed steps

### Key Concepts:

- **Processes**: Individual tasks or steps in the workflow
- **Channels**: Data structures for passing data between processes
- **Workflows**: Define the execution flow and dependencies
- **Configuration**: Separate configuration files for different execution environments


---

## Pipeline Overview

This pipeline performs the following steps:

1. **Quality Control (Raw)**: FastQC analysis on raw FASTQ files
2. **Read Trimming**: Adapter removal and quality trimming using Trimmomatic
3. **Quality Control (Trimmed)**: FastQC analysis on trimmed reads
4. **Read Alignment**: Align reads to reference genome using BWA
5. **SAM to BAM Conversion**: Convert alignment files to binary format
6. **Sort & Index BAM**: Prepare BAM files for downstream analysis
7. **Variant Calling**: Identify genetic variants using GATK/BCFtools
8. **Report Generation**: Aggregate QC metrics with MultiQC

---

## Prerequisites

Before running this pipeline, ensure you have the following installed:

- **Nextflow** (version 21.04 or higher)
- **Java** (version 8 or higher) - required for Nextflow
- **Conda/Miniconda** or **Mamba** - for environment management
- **Git** - for version control

### Check Installations:

```bash
# Check Nextflow
nextflow -version

# Check Java
java -version

# Check Conda
conda --version

# Check Git
git --version
```

---

## Installation & Setup

### 1. Install Nextflow

```bash
# Download Nextflow
curl -s https://get.nextflow.io | bash

# Make it executable
chmod +x nextflow

# Move to a directory in your PATH
sudo mv nextflow /usr/local/bin/
# OR add to your PATH
export PATH=$PATH:$PWD
```

### 2. Install Conda (if not already installed)

```bash
# Download Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Install Miniconda
bash Miniconda3-latest-Linux-x86_64.sh

# Follow the prompts and restart your terminal
```

### 3. Clone the Repository

```bash
# Clone the repository
git clone https://github.com/PrernaShamshapure/Nextflow_Pipeline.git

# Navigate to the pipeline directory
cd Nextflow_Pipeline
```

---

## Environment Setup

### Option 1: Automatic Environment Creation (Recommended)

The pipeline will automatically create the Conda environment when you run it for the first time using the `environment.yml` file.

```bash
# Nextflow will automatically create the environment
nextflow run main.nf -profile conda
```

### Option 2: Manual Environment Creation

```bash
# Create Conda environment from the YAML file
conda env create -f environment.yml

# Activate the environment
conda activate bnf

# Verify installation
conda list
```

### Environment Contents

The `environment.yml` file includes:

- **FastQC**: Quality control for sequencing data
- **Trimmomatic**: Read trimming and filtering
- **BWA**: Read alignment tool
- **SAMtools**: SAM/BAM file manipulation
- **BCFtools**: Variant calling and manipulation
- **GATK**: Genome Analysis Toolkit (if included)
- **MultiQC**: Aggregate QC reports

---

### How to run the pipeline

```bash
# Run the pipeline with default parameters
nextflow run main.nf

# Run with Conda profile
nextflow run main.nf -profile conda

# Resume a previous run
nextflow run main.nf -resume
```

### Configuration

Edit `nextflow.config` to customize:

- Input/output directories
- Reference genome paths
- Resource allocations (CPU, memory)
- Executor settings (local, HPC, cloud)

Example configuration:

```groovy
params {
    reads = "data/*_{R1,R2}.fastq.gz"
    reference = "genome/reference.fasta"
    outdir = "results"
}

process {
    cpus = 4
    memory = '8 GB'
}
```

---

## Pipeline Modules

The pipeline is organized into modular components:

### Core Modules (`modules/`)

- **`fastq_raw.nf`**: Quality control on raw FASTQ files
- **`trim_reads.nf`**: Adapter trimming and quality filtering
- **`fastq_trimmed.nf`**: Quality control on trimmed reads
- **`align_reads.nf`**: Read alignment to reference genome
- **`sam_to_bam.nf`**: Convert SAM to BAM format
- **`sort_index_bam.nf`**: Sort and index BAM files
- **`variant_calling.nf`**: Call variants from aligned reads
- **`multiqc.nf`**: Generate comprehensive QC report

### Workflow Definition (`workflows/`)

- **`workflow.nf`**: Defines the execution flow and connects modules

### Main Entry Point

- **`main.nf`**: Pipeline entry point that imports and executes the workflow

---

## Output

Results are organized in the output directory (default: `results/`):

```
results/
├── fastqc_raw/          # Raw read QC reports
├── trimmed_reads/       # Trimmed FASTQ files
├── fastqc_trimmed/      # Trimmed read QC reports
├── aligned_reads/       # BAM alignment files
├── sorted_bam/          # Sorted and indexed BAM files
├── variants/            # VCF variant files
└── multiqc/             # Aggregated QC report
```

### Key Output Files:

- **FastQC Reports**: HTML reports showing read quality metrics
- **BAM Files**: Aligned and sorted read alignments
- **VCF Files**: Variant call format files with detected variants
- **MultiQC Report**: Comprehensive summary of all QC metrics

---

## Git Operations

### Initial Setup

If you're creating a new repository:

```bash
# Initialize Git repository
git init

# Configure your Git identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Add files to staging
git add .

# Create initial commit
git commit -m "Initial commit: Nextflow pipeline modules"

# Add remote repository
git remote add origin https://github.com/YourUsername/YourRepo.git

# Rename branch to main (if needed)
git branch -m master main

# Push to GitHub
git push -u origin main
```

### Cloning the Repository

```bash
# Clone the repository
git clone https://github.com/PrernaShamshapure/Nextflow_Pipeline.git

# Navigate to the directory
cd Nextflow_Pipeline
```

### Common Git Commands

```bash
# Check status
git status

# Pull latest changes
git pull origin main

# Create a new branch
git checkout -b feature-branch

# Add changes
git add filename.nf
# Or add all changes
git add .

# Commit changes
git commit -m "Description of changes"

# Push changes
git push origin branch-name

# View commit history
git log --oneline

# View remote repositories
git remote -v
```

### Best Practices

1. **Use `.gitignore`**: Exclude temporary files and large data files
   ```
   # .gitignore example
   .nextflow/
   .nextflow.log*
   work/
   results/
   *.bam
   *.fastq
   *.fastq.gz
   ```

2. **Commit frequently** with descriptive messages

3. **Use branches** for new features or experiments

4. **Pull before push** to avoid conflicts

---

## Troubleshooting

### Common Issues:

**1. Nextflow not found:**
```bash
# Add Nextflow to PATH
export PATH=$PATH:/path/to/nextflow
```

**2. Conda environment activation fails:**
```bash
# Initialize Conda
conda init bash
# Restart terminal
source ~/.bashrc
```

**3. Permission denied errors:**
```bash
# Make scripts executable
chmod +x main.nf
```

**4. Memory errors:**
- Increase memory allocation in `nextflow.config`
- Reduce number of parallel processes

**5. Resume not working:**
```bash
# Clean work directory and restart
rm -rf work/
nextflow run main.nf
```

---

## Project Structure

```
Nextflow_Pipeline/
├── main.nf                 # Main pipeline entry point
├── nextflow.config         # Configuration file
├── environment.yml         # Conda environment specification
├── README.md              # This file
├── .gitignore             # Git ignore rules
├── modules/               # Pipeline modules
│   ├── align_reads.nf
│   ├── fastq_raw.nf
│   ├── fastq_trimmed.nf
│   ├── multiqc.nf
│   ├── sam_to_bam.nf
│   ├── sort_index_bam.nf
│   ├── trim_reads.nf
│   └── variant_calling.nf
└── workflows/             # Workflow definitions
    └── workflow.nf
```
