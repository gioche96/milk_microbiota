#!/bin/sh

##########################################################################
##		      Script to trim low quality parts                	##
##########################################################################

## Setting the environmnent
project_home="$(pwd)"           ## This is supposed to be the main folder
indir="$(pwd)/3_MICCA/3.1_Cutadapt"
outdir="$(pwd)/3_MICCA"
sickle_container="/usr/users/gchessa/bin/sickle"
core=8

## Load Singularity module
module load singularity

## Make outdir folder
if [ ! -d "${outdir}/3.2_Trimming" ]; then
        mkdir -p ${outdir}/3.2_Trimming
fi

## Trimming process for low quality parts
# Q = 20 inspect quality, eventually Q = 25 can be set for 16S data

cd "${indir}"

## Remove previous report files
if [ -f "${outdir}/3.4_Quality_control/Trimming_report.txt" ]; then
        rm ${outdir}/3.4_Quality_control/Trimming_report.txt
fi

while read file
do
        echo "Running sickle on file "${file}""
        echo "Running sickle on file "${file}"" >> ${outdir}/3.4_Quality_control/Trimming_report.txt
       
       ## Watch out for the read indicator (R1/R2 or 1/2 etc..)
        r1="R1" ## delimiter R1
        r2="R2" ## delimiter R2

echo ${indir}
temp=`pwd`
echo ${temp}

singularity run $sickle_container sickle pe \
-f "${file}_R2_cutadapt.fastq.gz" \
-r "${file}_R1_cutadapt.fastq.gz" \
-o ${outdir}/3.2_Trimming/"${file}_trimmed_R2.fastq.gz" \
-p ${outdir}/3.2_Trimming/"${file}_trimmed_R1.fastq.gz" \
-s ${outdir}/3.2_Trimming/"${file}_singles.gz" \
-t sanger \
-q 25 \
-g 1 \
>> ${outdir}/3.4_Quality_control/Trimming_report.txt

done < Sample_name.txt

## Give permissions to subfolders and files
chmod -R g+rwx /usr/users/gchessa/2_CNR_Microbiota_2/PROVA_Microbiota/*  ## Main folder

echo "DONE!"

exit 0

##########################################################################
