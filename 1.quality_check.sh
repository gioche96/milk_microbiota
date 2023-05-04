#!/bin/bash

##########################################################################
##           Script to perform Quality check on FastQ raw files         ##
##########################################################################

## Required software
module load fastqc
module load python/3
module load multiqc

## Setting the environment
currpath="$(pwd)"   		        ## This is supposed to be the main folder
input="$(pwd)/0_Original_files"   	## Change according to the input files folder
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

## Give permissions to subfolders and files
chmod -R g+rwx $(pwd)

echo "Done"

exit 0

##########################################################################
