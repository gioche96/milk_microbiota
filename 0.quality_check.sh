#!/bin/bash

## Required software
module load fastqc
module load python/3
module load multiqc

## Setting the environment
currpath="pwd"   				## Change according to the pwd
input="$(pwd)/0_Original_files"   	## Change according to the input folder
outdir="$(pwd)/1_Quality_check"
core=8

## Make folder
	if [ ! -d "${outdir}" ]; then
		mkdir -p ${outdir}
fi

## FastQC
	cd ${outdir}
echo "running FASTQC from locally installed software"
fastqc ${input}/*.fastq.gz -o ${outdir}

## MultiQC
	cd ${outdir}
echo "running MultiQC from locally installed software"
multiqc .

echo "Done"
