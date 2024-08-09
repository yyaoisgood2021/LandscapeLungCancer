#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=SAMPLE    # Job name
#SBATCH --output=SAMPLE.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=SAMPLE.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=4     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=30G   # memory per NODE

codedir=/home/lina/lung.chipseq.project/chipseq.code/
seqdate=
datafolder=/home/lina/lung.chipseq.project/$seqdate/process/SAMPLE/
output=/home/lina/lung.chipseq.project/data/frip/`basename $seqdate`.SAMPLE.frip.txt

for i in $datafolder/25_*;
do
	~/programfile/miniconda/miniconda2/bin/python $codedir/frip.deeptools.py $i/deduplicate/*.sorted.dedup.Q10.bam $i/peakcalling/standard/narrow/*.narrowPeak `basename $i` $seqdate narrow MACS2>> $output;
	~/programfile/miniconda/miniconda2/bin/python $codedir/frip.deeptools.py $i/deduplicate/*.sorted.dedup.Q10.bam $i/peakcalling/standard/broad/*.broadPeak `basename $i` $seqdate broad MACS2>> $output;
	~/programfile/miniconda/miniconda2/bin/python $codedir/frip.deeptools.py $i/deduplicate/*.sorted.dedup.Q10.bam $i/peakcalling/blueprint/narrow/*.narrowPeak `basename $i` $seqdate narrow MACS2.blueprint>> $output;
	~/programfile/miniconda/miniconda2/bin/python $codedir/frip.deeptools.py $i/deduplicate/*.sorted.dedup.Q10.bam $i/peakcalling/blueprint/broad/*.broadPeak `basename $i` $seqdate broad MACS2.blueprint>> $output;
	~/programfile/miniconda/miniconda2/bin/python $codedir/frip.deeptools.py $i/deduplicate/*.sorted.dedup.Q10.bam $i/peakcalling/epic2.broadpeak/*.broadpaeks.txt `basename $i` $seqdate broad epic2 >> $output;
	~/programfile/miniconda/miniconda2/bin/python $codedir/frip.deeptools.py $i/deduplicate/*.sorted.dedup.Q10.bam $i/peakcalling/homer/*.homer.broadpeaks.txt `basename $i` $seqdate broad homer >> $output;
done;
	
