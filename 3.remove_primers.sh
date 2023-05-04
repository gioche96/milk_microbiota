#!/bin/sh

##########################################################################
##		   Script to remove primers and adapters		##
##########################################################################

## Loading cutadapt
module load cutadapt

## Setting the environmnent
project_home="$(pwd)"		## This is supposed to be the main folder
datapath="$(pwd)/2_Renamed_and_count"
outdir="$(pwd)/3_MICCA"
core=8

## Make folders
if [ ! -d "${outdir}/3.1_Cutadapt" ]; then
		mkdir -p ${outdir}/3.1_Cutadapt
fi

if [ ! -d "${outdir}/3.2_Trimming" ]; then
		mkdir -p ${outdir}/3.2_Trimming
fi

if [ ! -d "${outdir}/3.3_Join_reads" ]; then
		mkdir -p ${outdir}/3.3_Join_reads
fi

if [ ! -d "${outdir}/3.4_Quality_control" ]; then
		mkdir -p ${outdir}/3.4_Quality_control
fi

## Create a file of sample names that will be used for looping. Extensions and R1/R2 are removed.
cd "${datapath}"

	## Remove any possible old file named as Sample_name_dupl.txt
		if [ -f "Sample_name_dupl.txt" ]; then
			rm Sample_name_dupl.txt
		fi

for i in *.fastq.gz
do
	echo "$i" | cut -d "_" -f1 >> Sample_name_dupl.txt
done

## Printing (n) a line and deleting (d) the following one = Creating a list with no duplicates
sed '{n;d}' Sample_name_dupl.txt > Sample_name.txt

cp Sample_name.txt ${outdir}/3.1_Cutadapt
cp Sample_name.txt ${outdir}/3.2_Trimming
cp Sample_name.txt ${outdir}/3.3_Join_reads
mv Sample_name.txt ${outdir}/3.4_Quality_control	## Replace mv with cp if you want to have a copy of the list file also in 2_Renamed_and_count folder
rm Sample_name_dupl.txt	   ## To remove the list of duplicates in 2_Renamed_and_count folder

## Primer sequences (primers follow the adapters)
fwd_primer="CCTACGGGNGGCWGCAG" 
#(adapter: TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG)
rev_primer="GACTACHVGGGTATCTAATCC" 
#(adapter: GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG)

## Adding Cutadapt PATH to the normal $PATH env 
## Type > "which cutadapt" to check its PATH
export PATH="/usr/product/bioinfo/CUTADAPT/2.3/bin/cutadapt:$PATH" 

## Performing Cutadapt
cd "${datapath}"
	echo $(pwd)

	while read file
		do
		     echo "Running cutadapt on file '${file}'"
			## Watch out for the read indicator (R1/R2 or 1/2 etc..)
cutadapt 
-g Forward=${fwd_primer} 
-G Reverse=${rev_primer} 
--discard-untrimmed 
--pair-filter=any 
-o "${outdir}/3.1_Cutadapt/${file}_R1_cutadapt.fastq.gz" 
-p "${outdir}/3.1_Cutadapt/${file}_R2_cutadapt.fastq.gz" 
"${file}_R1.fastq.gz" 
"${file}_R2.fastq.gz" 
>> "${outdir}/3.4_Quality_control/Cutadapt_report.txt"  

		done < ${outdir}/3.1_Cutadapt/Sample_name.txt


#--discard-untrimmed, --trimmed-only
#                        Discard reads that do not contain an adapter.

#--pair-filter=(any|both|first)
#                        Which of the reads in a paired-end read have to match
#                        the filtering criterion in order for the pair to be
#                        filtered. Default: any

#--no-indels
#				 Discard adapters with insertions and deletions, 
#				 reducing the error tolerance

## Give permissions to the subfolders and files
chmod -R g+rwx /scratch/users/gchessa/PROVA_Microbiota/*  ## Main folder

echo "DONE!"
  
exit 0

##########################################################################
