#!/bin/sh

##########################################################################
##		Script to rename samples and count the reads		##
##########################################################################

## Setting the environmnent
project_home="$(pwd)"		      ## This is supposed to be the main folder
datapath="$(pwd)/0_Original_files"    ## Change according to the original files folder
outdir="$(pwd)/2_Renamed_and_count"
core=8

## Make folder
cd $project_home

if [ ! -d $outdir ]; then
	mkdir -p $outdir
fi

## Rename samples
cd $datapath

for i in *.fastq.gz
do
  exte=".fastq.gz" ## Final extension
  sample=$(echo "$i" | cut -d "_" -f2) ## It depends on the structure of the name
  read=$(echo "$i" | cut -d "_" -f5) ## It depends on the structure of the name
  cp $i ${outdir}/$sample"_"$read$exte
  echo -e "$i\t-->\t$sample"_"$read$exte" >> ${outdir}/Renamed_samples.txt
done

## Count reads
cd ${outdir}

for i in *.fastq.gz
do
        echo -n $i >> Seq_count_16S_raw.txt
        echo -n " = " >> Seq_count_16S_raw.txt
        echo $(zcat $i | wc -l) / 4 | bc >> Seq_count_16S_raw.txt   ## The sum is divided by 4 because for each sequence there are 4 lines of information
done

## Give permissions to subfolders and files
chmod -R g+rwx /usr/users/gchessa/PROVA_Microbiota/*  ## Main folder

echo "DONE!"

exit 0

##########################################################################
