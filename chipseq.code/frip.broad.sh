#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=frip    # Job name
#SBATCH --output=frip.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=frip.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=1     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=56G   # memory per NODE

wk=/home/lina/lung.chipseq.project/data/chipseq.07282020/igm-storage2.ucsd.edu/process-Q10/sINDEX/

output=/home/lina/lung.chipseq.project/data/chipseq.07282020/igm-storage2.ucsd.edu/process-Q10/FRIP/

bedtools intersect -a $wk/deduplicate/JE-6_SINDEX_L008_R1_001.sorted.dedup.Q10.bed -b $wk/peakcalling/standard/broad/JE-6_SINDEX_L008_R1_001_peaks.broadPeak -wa | sort | uniq >  $output/SINDEX.Q10.reads.in.peaks.standard.bed

bedtools intersect -a $wk/deduplicate/JE-6_SINDEX_L008_R1_001.sorted.dedup.Q10.bed -b $wk/peakcalling/blueprint/broad/JE-6_SINDEX_L008_R1_001_peaks.broadPeak -wa | sort | uniq >  $output/SINDEX.Q10.reads.in.peaks.blueprint.full.bed

bedtools intersect -a $wk/deduplicate/JE-6_SINDEX_L008_R1_001.sorted.dedup.Q10.bed -b $wk/peakcalling/blueprint/halfsize.broad/JE-6_SINDEX_L008_R1_001_peaks.broadPeak -wa | sort | uniq >  $output/SINDEX.Q10.reads.in.peaks.blueprint.half.bed



