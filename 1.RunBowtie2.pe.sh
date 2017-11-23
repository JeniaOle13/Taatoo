#! /bin/bash 

BOWTIE2_DB=./megares/index_bowtie2/megares_bowtie2

for i in *_1.fastq.gz
do 
	rname=$(basename $i _1.fastq.gz)
	bowtie2 -x $BOWTIE2_DB -1 $i -2 ${rname}_2.fastq.gz -S ${rname}.sam -p 24 --no-unal --non-deterministic  
done
