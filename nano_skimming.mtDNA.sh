#pipeline accompanying Malukiewicz et al. Genomic Skimming and Nanopore SequencingUncover Cryptic Hybridization in One of World’s Most Threatened Primates for assembly of mitogenome from minION data after Guppy base calls 

#####software needed####
#Porechop 0.2.4
#NanoFilt 2.7.1
#mtblaster script https://github.com/nidafra92/squirrel-project/blob/master/mtblaster.py
#flye 2.8.2


#remove adaptors
porechop --format fastq -i guppy_call.fastq  -o guppy_call.adprm.fastq


#filter reads for quality 
NanoFilt -q 7   guppy_call.adprm.fastq  > guppy_call.flt.fastq

#identify candidate mtDNA reads from filtered minION sequence data using reference mitogenome, we used C. aurita mitogenome GenBank Accession #  
python mtblaster.py guppy_call.flt.fastq mtDNA.reference.fa

#the mtblaster.py script will output a series of files that include "reads_w_hits.fastq" which are the reads that represent candidate mitochondrial sequences 

#de novo assembly and polishing of mitogenome sequence 
flye --nano-raw reads_w_hits.fastq --out-dir out_mtdna_flye/
