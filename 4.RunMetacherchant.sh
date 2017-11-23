#! /bin/bash 
READS_DIR= #select reads directory 

i= #select k-size
j= #select k-mers aubundance

find -name "genes.fasta" > gene.list

while read gene
do
	rname=$(dirname $gene | sed "s/.\///")		
	
	metacherchant.sh --tool environment-finder \
        -k $i \
        --reads $sample $READS_DIR/${rname}_1.fastq.gz $READS_DIR/${rname}_2.fastq.gz \
        --seq $gene \
        --output "./metacherhcant/$rname/output" \
        --coverage=$j \
        --work-dir "./metacherchant$rname/workDir" \
        --maxkmers=100000 \
        --bothdirs=False \
        --chunklength=1 \
	-p 10 \
	--trim

done<gene.list
