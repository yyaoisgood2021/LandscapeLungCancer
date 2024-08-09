#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=frip.SAMPLE    # Job name
#SBATCH --output=frip.SAMPLE%j.out # Stdout (%j expands to jobId)
#SBATCH --error=frip.SAMPLE%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=1     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=56G   # memory per NODE

wk=/home/lina/lung.chipseq.project/A549.rawdata/SAMPLE/
output=/home/lina/lung.chipseq.project/A549.rawdata/FRIP/

bedtools intersect -a $wk/deduplicate/SAMPLE.sorted.dedup.Q10.bed -b $wk/peakcalling/standard/narrow/A549.SAMPLE_peaks.narrowPeak -wa | sort | uniq >  $output/SAMPLE.Q10.reads.in.peaks.standard.bed

bedtools intersect -a $wk/deduplicate/SAMPLE.sorted.dedup.Q10.bed -b $wk/peakcalling/blueprint/narrow/A549.SAMPLE_peaks.narrowPeak -wa | sort | uniq >  $output/SAMPLE.Q10.reads.in.peaks.blueprint.full.bed

bedtools intersect -a $wk/deduplicate/SAMPLE.sorted.dedup.Q10.bed -b $wk/peakcalling/blueprint/halfsize.narrow/A549.SAMPLE_peaks.narrowPeak -wa | sort | uniq >  $output/SAMPLE.Q10.reads.in.peaks.blueprint.half.bed






