#! /bin/bash

krakendb= #select Kraken DB directory

find -name "seqs.fasta" > seqs.list

while read seqname
do
    seqdir=$(dirname $seqname)
    kraken --db $krakendb $seqdir/seqs.fasta > $seqdir/seqs.kraken --threads 12
    kraken-translate --db $krakendb $seqdir/seqs.kraken > $seqdir/seqs.labels
done<seqs.list
