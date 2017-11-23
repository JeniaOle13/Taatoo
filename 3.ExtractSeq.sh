#!/bin/bash

# Create metacherchant output directories
mkdir metacherchant

for i in *.sam 
	do rname=$(basename $i .sam)
	mkdir metacherchant/$rname
done
# Extract DNA sequnce from MEGARes database
R -f src/extractDNA.R 
