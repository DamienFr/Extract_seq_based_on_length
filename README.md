# Description
Extract sequences from a fasta or fastq file based on their length

# Usage
perl Extract_fasta_or_fastq_sequence_based_on_size.pl -i in.fasta|.fa|.fastq|.fq -s 100 -t superior [-o output_file]

# Options
        -i or -input:	fasta or fastq file	(REQUIRED)
	-s or -size:	Filtering size (REQUIRED)
	-t or -type:	superior/inferior . Sizes to KEEP relative to the filtering size (REQUIRED)
	-o or -out:	Output File	(DEFAULT: [input_name].size.filtered)
	-h or -help:	This Documentation
  
# Author
Damien Richard, 2019
  
