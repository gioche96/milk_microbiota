# Repository for microbiota analysis 🦠
The following repository contains all pipelines and scripts I used to analyse milk microbiota composition in sheep and goat breeds. DNA was first extracted from individual milk samples; regions V3-V4 of 16S were amplified using a specific PCR-based technique and the amplicons were sequenced through Illumina NovaSeq.

*See the **[WIKI](https://github.com/gioche96/milk_microbiota/wiki)** for further information!!!*

<br>

## Required software
**FastQC**: it is software primarily used to provide quality control on raw sequence data coming from high-throughput sequencing pipelines. 

**MultiQC**: it allows generating an overall quality report of all raw sequences.

**Cutadapt**: it finds and removes adapter sequences, primers, poly-A tails and other types of unwanted sequence from high-throughput sequencing reads.

**MICCA**: it is one of the pipelines used in microbiota and microbiome analysis. 

<br>

## Workflow
*1.quality_check.sh*  =  Quality check of the raw sequences (see _0.fastqc.sh_ and _0.multiqc.py_ for independent use).

*2.rename_and_count.sh*  =  Changing raw sample names to new names with a predefined format. Reads for each sample are also counted. 

*3.remove_primers.sh*  =  Removing primers and adapters from raw sequences. 

<p align="right">
<sub>Support and development: @filippob<sub>
</p>
