#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=25-27-1.rna   # Job name
#SBATCH --output=UCSD25-27-1.rna.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=UCSD25-27-1.rna.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=8     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=30G   # memory per NODE


bash /home/lina/lung.chipseq.project/RNA.seq.code/lung-RNAseq.pipeline.run.sh /home/lina/lung.chipseq.project/data/chipseq.03252021/igm-storage2.ucsd.edu/210320_K00180_1016_AHKHHLBBXY_SR75_Combo/25_27_RNA-1_S49_L005_R1_001.fastq.gz /home/lina/lung.chipseq.project/data/chipseq.03252021/process/UCSD.025-27-RNA/25_27-RNA-1/ 25_27-RNA-1
