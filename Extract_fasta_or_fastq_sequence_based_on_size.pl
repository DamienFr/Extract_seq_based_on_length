#!/usr/bin/perl
use Bio::SeqIO;
use Getopt::Long;

# use strict;
# use warnings;
# use Text::CSV;

=head1 DESCRIPTION

	Extract sequences from a fasta or fastq file based on their length.

=head1 USAGE

	perl Extract_fasta_or_fastq_sequence_based_on_size.pl -i in.fasta|.fa|.fastq|.fq -s 100 -t superior [-o output_file]

=head1 OPTIONS

	-i or -input:	fasta or fastq file	(REQUIRED)
	-s or -size:	Filtering size (REQUIRED)
	-t or -type:	superior/inferior . Sizes to KEEP relative to the filtering size (REQUIRED)
	-o or -out:	Output File	(DEFAULT: [input_name].size.filtered)
	-h or -help:	This Documentation

=head1 AUTHOR

	Damien Richard, 2019

=cut

my $fastq_file; my $size; my $type; my $out; my $hl;

GetOptions(
	"i|input=s" => \$fastq_file,
	"s|size=s" => \$size,
	"t|type=s" => \$type,
	"o|out=s" => \$out,
	"h|help" => \$hl
);

die `pod2text $0` unless $size && $fastq_file && $type && ( $type eq "superior" || $type eq "inferior" );
die `pod2text $0` if $hl;

my $input_type;
if($fastq_file =~ /.*.fa/ || $fastq_file =~ /.*.fasta/){ $input_type = "fasta" }elsif($fastq_file =~ /.*.fq/ || $fastq_file =~ /.*.fastq/){ $input_type = "fastq" }else{ print STDERR "Input type not recognized. " . $fastq_file . " has to display .fa .fasta .fq or .fastq extension\n"; die `pod2text $0` }

print STDERR "Input type is " . $input_type . "\n";

if(!$out){$out = $fastq_file . ".size.filtered";}
# End of user interface code, beginning of program: 

my $fastq_in ;
my $fastq_out;

if($input_type eq "fastq"){

 $fastq_in  = Bio::SeqIO->new( -file => $fastq_file,       -format => 'fastq' );
 $fastq_out = Bio::SeqIO->new( -file => ">" . $out, -format => 'fastq' );
print "Processing fastq file ...\n";

}else{

$fastq_in  = Bio::SeqIO->new( -file => $fastq_file,       -format => 'fasta' );
 $fastq_out = Bio::SeqIO->new( -file => ">" . $out, -format => 'fasta' );
print "Processing fasta file ...\n";

}

while ( my $seq = $fastq_in->next_seq() ) {
	$nb_in++;
	my $actual_length = $seq->length() ;   

 if ( $type eq "inferior" && $actual_length < $size ) {
    $nb_out++;
        $fastq_out->write_seq($seq);
    }

 if ( $type eq "superior" && $actual_length > $size ) {
    $nb_out++;
        $fastq_out->write_seq($seq);
    }
}

print "Process terminated, output file is $out\nIt contains $nb_out out of $nb_in sequences of original fastq/fasta file\n";
print "This program does not check whether all the titles of the csv file are present in the fastq/fasta file. It will only extract found identifiers without warning you that some were not found"


