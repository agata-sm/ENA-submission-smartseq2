#!/bin/bash -l

indir="/path/to/fastq_qz_dir"

filext="*.fastq.gz"

infiles=$indir"/**/"$filext

WEBIN_HOME=""

manifest_tmpl="/path/to/manifest.txt"

for infile in $infiles
do

	infile_fname=${infile##*/}
	infile_base=${infile_fname%%_R1.fastq.gz}


	indir_smpl=$indir"/"$infile_base

	stdout_smpl=$infile_base"/"$infile_base".stdouterr"

	manifest_smpl=$infile_base"/"$infile_base".manifest.txt"
	mkdir -p $infile_base

	cp $manifest_tmpl $manifest_smpl

	#echo "$indir_smpl"

	printf "SAMPLE\t$infile_base\n" >> $manifest_smpl
	printf "NAME\t$infile_base\n" >> $manifest_smpl
	printf "FASTQ\t$infile_fname\n" >> $manifest_smpl

	java -jar $WEBIN_HOME/webin-cli-4.1.0.jar -context reads -manifest $manifest_smpl -username=$WEBIN_USR -passwordEnv=$VAR -submit -inputDir $indir_smpl $stdout_smpl 2>&1

	wait

done


echo "*** all done ***"