#!/bin/bash

res_analizer=./megares/resistomeanalyzer/resistome
database=./megares/database


for i in *sam
do
	rname=$(basename $i .sam)
	$res_analizer -ref_fp $database/megares_database_v1.01.fasta -sam_fp $i -annot_fp $database/megares_annotations_v1.01.csv -gene_fp ${rname}_gene.tsv -group_fp ${rname}_group.tsv -class_fp ${rname}_class.tsv -mech_fp ${rname}_mech.tsv -t 80	
done
