#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=25-5-1.rna   # Job name
#SBATCH --output=UCSD25-5-1.rna.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=UCSD25-5-1.rna.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=12     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=56G   # memory per NODE


bash /home/lina/lung.chipseq.project/RNA.seq.code/lung-RNAseq.pipeline.run.sh /home/lina/lung.chipseq.project/data/chipseq.11202020/igm-storage2.ucsd.edu/201120_K00180_0997_AHKCCCBBXY_SR_75_Combo/25_5_RNA-1_S22_L005_R1_001.fastq.gz /home/lina/lung.chipseq.project/data/chipseq.11202020/process/UCSD.025-5-RNA/25_5_RNA-1 25_5_RNA-1
