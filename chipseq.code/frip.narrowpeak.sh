#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=SAMPLE.frip    # Job name
#SBATCH --output=SAMPLE.frip%j.out # Stdout (%j expands to jobId)
#SBATCH --error=SAMPLE.frip%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=1     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=35G   # memory per NODE

filedir=/home/lina/lung.chipseq.project/data/chipseq.11202020/process/UCSD.025-5/

outdir=/home/lina/lung.chipseq.project/data/chipseq.11202020/process/UCSD.025-5/FRIP/

mkdir $outdir/SAMPLE/

bedtools intersect -a $filedir/SAMPLE/deduplicate/SAMPLE*sorted.dedup.Q10.bed -b $filedir/SAMPLE/peakcalling/standard/narrow/SAMPLE_peaks.narrowPeak -wa | sort | uniq >  $output/SAMPLE/SAMPLE.Q10.reads.in.peaks.standard.bed

bedtools intersect -a $filedir/SAMPLE/deduplicate/SAMPLE*sorted.dedup.Q10.bed -b $filedir/SAMPLE/peakcalling/blueprint/narrow/SAMPLE_peaks.narrowPeak -wa | sort | uniq >  $output/SAMPLE/SAMPLE.Q10.reads.in.peaks.blueprint.full.bed

bedtools intersect -a $filedir/SAMPLE/deduplicate/SAMPLE*sorted.dedup.Q10.bed -b $filedir/SAMPLE/peakcalling/blueprint/halfsize.narrow/SAMPLE_peaks.narrowPeak -wa | sort | uniq >  $output/SAMPLE/SAMPLE.Q10.reads.in.peaks.blueprint.half.bed






