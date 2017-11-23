# Taatoo
# Introduction
Taatoo - (Taxonomic association toolchain) is a pipeline for calculating taxonomic associations between target sequence (for example, antibiotic resistance genes) and different taxonomic levels of bacteria. 
# Dependencies
Scripts relies on bowtie2, MetaCherchant and Kraken software. For Kraken, should to install Kraken used database (see https://ccb.jhu.edu/software/kraken/MANUAL.html).  Please install both and put them in your executable search path. 
Also, you will need to install R and dplyr, seqinr, data.table, taxize libraries for R.
# Usage
1. To calculate abundance of ARGs for your samples (paired-end Illumina samples), run
   $ bash RunBowtie2.pe.sh | bash RunResun

   To calculate of abundance for single-end Illumina reads, run
   $ bash RunBowtie2.se.sh | bash RunResun


2. To extract target sequence from MEGARes fasta file, run
   $ bash ExtractSeq.sh


3. To construct ARGs metagenomic context for each gene, run 
   $ bash RunMetacherchant.sh


4. For taxonomic annotations of graph’s unitigs, run
   $ bash RunKraken.sh


5. For build results in table output format, run
   $ R -f src/main.R 
