#!/bin/bash

## Required software
module load fastqc

## Setting the environment
input="pwd"		## Change according to the pwd

## Performing FastQC locally
for i 
in ${pwd}*.fastq.gz;
do sbatch -p medium -C scratch -t 0-01:00:00 -c4 -N 1 --wrap="fastqc ${i} > ${i}_out.txt";
done
