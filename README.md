# Repository for microbiota analysis 🦠
The following repository contains all pipelines and scripts I used to analyse milk microbiota composition in sheep and goat breeds. DNA was first extracted from individual milk samples; regions V3-V4 of 16S were amplified using a specific PCR-based technique and the amplicons were sequenced through Illumina NovaSeq.


## The required software are:
> **FastQC**: it is software primarily used to provide quality control on raw sequence data coming from high-throughput sequencing pipelines. It works on _.fastq.gz_ files, generating a _.zip_ and a _.html_ (online report) files for each sample.
> - [Official website](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
> - [Documentation](https://raw.githubusercontent.com/s-andrews/FastQC/master/INSTALL.txt)
> - [Container](https://hub.docker.com/r/biocontainers/fastqc)
> - Singularity: _singularity build fastqc-0.11.9_cv7.sif docker://biocontainers/fastqc:v0.11.9_cv7_

> **MultiQC**: it allows generating an overall quality report of all raw sequences, by computing the _.zip_ files generated during the FastQC check.
> - [Official website](https://multiqc.info/)
> - [Documentation](https://multiqc.info/docs/)
> - Container: _docker run -t -v pwd:pwd -w pwd \ ewels/multiqc ._

> **micca**: it is one of the pipelines used in microbiota and microbiome analysis. 
> [...]

## The steps are:
> _1.quality_check.sh_  =  Quality check of the raw sequences (see _0.fastqc.sh_ and _0.multiqc.py_ for independent use).





<sub>Support and development: @filippob<sub>
