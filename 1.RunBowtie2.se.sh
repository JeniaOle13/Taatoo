#! /bin/bash 

BOWTIE2_DB=./megares/index_bowtie2/megares_bowtie2

for i in *.fastq.gz
do 
	rname=$(basename $i .fastq.gz)
	bowtie2 -x $BOWTIE2_DB -U $i -S ${rname}.sam -p 24 --no-unal --non-deterministic  
done
