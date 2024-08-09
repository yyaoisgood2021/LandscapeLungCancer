#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=25-9-1.rna   # Job name
#SBATCH --output=UCSD25-9-1.rna.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=UCSD25-9-1.rna.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=10     # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=35G   # memory per NODE

bash /home/lina/lung.chipseq.project/RNA.seq.code/lung-RNAseq.pipeline.run.sh /home/lina/lung.chipseq.project/data/chipseq.02022021/igm-storage2.ucsd.edu/210130_K00180_1007_BHKHJNBBXY_SR75_Combo/25_9-re_RNA-1_S7_L001_R1_001.fastq.gz /home/lina/lung.chipseq.project/data/chipseq.02022021/process/UCSD.025-9-RNA/25-9-RNA-1/ 25-9-RNA-1
