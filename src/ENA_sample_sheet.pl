#!c:/perl/bin/perl.exe

# script to produce sample sheet for submission of scRNAseq data to ENA

#proj 4160

use warnings;
use strict;
use diagnostics;


my $annot_in="/path/to/Cells_info_384_plate.txt";

my $sample_sheet_out="PRJEBXXX_sample_sheet_ENA.tsv";


open (INFILE, "<", $annot_in) or die "$annot_in $!";
open (OUTFILE, ">", $sample_sheet_out) or die "$sample_sheet_out $!";


print OUTFILE "#checklist_accession\tERC000011\n";
print OUTFILE "#unique_name_prefix\n";

print OUTFILE "sample_alias\ttax_id\tscientific_name\tcommon_name\tsample_title\tsample_description\tdev_stage\ttissue_type\n";

my $taxid="10090";
my $sciname="Mus musculus";
my $comname="house mouse";
my $sample_desc="RNA-seq of mouse heart, single cell";
my $tissue="postnatal heart";


while(<INFILE>){
	chomp $_;
	unless ($_=~m/^Well/){
		my @line=split /\s+/;
		my $well=$line[0];
		my $devstage=$line[1];

		my $sample_title="scRNA-seq of mouse heart: $well";

		print OUTFILE "$well\t$taxid\t$sciname\t$comname\t$sample_title\t$sample_desc\t$devstage\t$tissue\n";
	}
}


print OUTFILE "#template\n";
print OUTFILE "#units\n";


close(INFILE);
close(OUTFILE);

