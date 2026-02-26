# Scripts for smartseq2 data submission to ENA


The process of data submission to ENA consists of two stages:

1. Sample registration

2. File submission

Scripts in this repo have been used to perform these steps (as well as create the sample data sheet) in 2021. Please note the procedure may have changed since.


## Sample registration

Before proceeding with submission the samples need to be registered at ENA. This is done via samplesheet file named `ACCESSION_sample_sheet_ENA.tsv`.

e.g. `PRJEB47622_sample_sheet_ENA.tsv`


Content of this file:

```
head PRJEB47622_sample_sheet_ENA.tsv
#checklist_accession	ERC000011
#unique_name_prefix
sample_alias	tax_id	scientific_name	common_name	sample_title	sample_description	dev_stage	tissue_type
A1	10090	Mus musculus	house mouse	scRNA-seq of mouse heart: A1	RNA-seq of mouse heart, single cell	P0	postnatal heart
A2	10090	Mus musculus	house mouse	scRNA-seq of mouse heart: A2	RNA-seq of mouse heart, single cell	P0	postnatal heart
A3	10090	Mus musculus	house mouse	scRNA-seq of mouse heart: A3	RNA-seq of mouse heart, single cell	P0	postnatal heart
A4	10090	Mus musculus	house mouse	scRNA-seq of mouse heart: A4	RNA-seq of mouse heart, single cell	P0	postnatal heart
A5	10090	Mus musculus	house mouse	scRNA-seq of mouse heart: A5	RNA-seq of mouse heart, single cell	P0	postnatal heart
A6	10090	Mus musculus	house mouse	scRNA-seq of mouse heart: A6	RNA-seq of mouse heart, single cell	P0	postnatal heart
A7	10090	Mus musculus	house mouse	scRNA-seq of mouse heart: A7	RNA-seq of mouse heart, single cell	P0	postnatal heart
```


This file can be generated using script `ENA_sample_sheet.pl` using information from config file `Cells_info_384_plate.txt`:

```
head Cells_info_384_plate.txt 
Well	Developmental stage	Fucci fluorescence	DNA content
A1	P0	Red	N/A
A2	P0	Red	N/A
A3	P0	Red	N/A
A4	P0	Red	N/A
A5	P0	Green	N/A
A6	P0	Green	N/A
A7	P0	Green	N/A
A8	P0	Green	N/A
A9	P7	Red	2N
```

The column parsed by the script are the 1st and the 2nd: `Well` and `Developmental stage`. This is hardcoded (by position), and can be changed via alterations in the source.

Please note the paths to files were originally hardcoded in the script, and were removed for inclusion in this repo. For the script to work, valid paths need to be supplied.


This samplesheet was submitted to ENA - I do not have notes on any command to do so, so I assume via their web portal.

Upon successful registartion, this email was received:

```
	Dear Colleague,

	Thank you for your recent submission to the European Nucleotide Archive with your account 'Webin-59988'.

	We are pleased to advise you that the metadata has passed validation and the following accession numbers have been assigned:

	Your sample will be held private with no limit of time.

	Please note that just by registering your samples these will not be affiliated with a study or any data. The association of samples with a study happens in subsequent steps when you submit sequence data and point to your sample(s) from experiment object(s).

	Please DO NOT reply to this email. If you need further assistance, contact ENA helpdesk https://www.ebi.ac.uk/ena/browser/support .

	Accession Summary
	-----------------
	Type Accession Unique Name
	Sample ERS7641403 (SAMEA9963106) A1
	Sample ERS7641404 (SAMEA9963107) A2
	Sample ERS7641405 (SAMEA9963108) A3
	(...)
```



## File submission

Files are submitted sequentially, as it was done from my local system.

Script `submit_ENA.sh` was used to submit the files.

File naming and directory structure was:

```
rawdata/A1/A1_R1.fastq.gz
rawdata/A2/A2_R1.fastq.gz
```


Please note the paths to certain config files were originally hardcoded in the script, and were removed for inclusion in this repo. For the script to work, valid paths need to be supplied.

Valid path to `webin` installation needs to be provided via the variable `$WEBIN_HOME`.

The path to `manifest.txt` needs also be provided in the script body.

Template for the manifest files `manifest.txt` used by the `submit_ENA.sh` script was:

```
cat manifest.txt 
STUDY	PRJEB47622
INSTRUMENT	Illumina HiSeq 2500
LIBRARY_SOURCE	TRANSCRIPTOMIC SINGLE CELL
LIBRARY_SELECTION	PolyA
LIBRARY_STRATEGY	RNA-Seq
DESCRIPTION	Smart-seq2 (Picelli et al. Nature Metods 2013)
```

Last but not least, the credentials are provided via variables:

* `$WEBIN_USR` user

* `$VAR` pwd

They can be set outside of the script.

While the script is running, directories are created for each well, and data is submitted.



