#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=SAMPLE.process    # Job name
#SBATCH --output=SAMPLE.process.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=SAMPLE.process.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=10   # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=45G   # memory per NODE

codedir=/home/lina/lung.chipseq.project/chipseq.code/
datafolder=/home/lina/lung.chipseq.project/data/chipseq.02022021/process/UCSD.025-9/
output=/home/lina/lung.chipseq.project/data/chipseq.02022021/process/UCSD.025-9/UCSD.025-9.FRIP.deeptools.output.txt
~/programfile/miniconda/miniconda2/bin/python $codedir/frip.deeptools.py $datafolder/SAMPLE/deduplicate/SAMPLE*sorted.dedup.Q10.bam $datafolder/SAMPLE/peakcalling/standard/narrow/SAMPLE*peaks.narrowPeak SAMPLE >> $output
