#!/bin/bash

for i 
in /scratch/users/gchessa/Microbiota_CNR2023/prova/*.fastq.gz;
do sbatch -p medium -C scratch -t 0-01:00:00 -c4 -N 1 --wrap="fastqc ${i} > ${i}_out.txt";
done
