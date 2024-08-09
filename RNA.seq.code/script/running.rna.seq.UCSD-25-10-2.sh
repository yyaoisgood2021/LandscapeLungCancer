#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=25-10-2.rna   # Job name
#SBATCH --output=UCSD25-10-2.notrim.rna.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=UCSD25-10-2.notrim.rna.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=10     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=56G   # memory per NODE

bash /home/lina/lung.chipseq.project/RNA.seq.code/lung-RNAseq.pipeline.run.sh /home/lina/lung.chipseq.project/data/chipseq.12202020/igm-storage2.ucsd.edu/201220_K00180_1002_BHKG2YBBXY_SR75_Combo/25_10_RNA-2_S21_L007_R1_001.fastq.gz /home/lina/lung.chipseq.project/data/chipseq.12202020/process/UCSD.025-10-RNA/25_10-RNA-2/ 25_10_RNA-2
