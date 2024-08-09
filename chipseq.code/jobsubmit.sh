#!/bin/bash

####################################
#     ARIS slurm script template   #
#                                  #
# Submit script: sbatch filename   #
#                                  #
####################################

#SBATCH --job-name=SAMPLENAME.process    # Job name
#SBATCH --output=SAMPLENAME.process.%j.out # Stdout (%j expands to jobId)
#SBATCH --error=SAMPLENAME.process.%j.err # Stderr (%j expands to jobId)
#SBATCH --ntasks=10   # Number of tasks(processes)
#SBATCH --nodes=1     # Number of nodes requested
#SBATCH --mem=40G   # memory per NODE

bash /home/lina/lung.chipseq.project/chipseq.code/pipeline.sh FASTQ OUTDIR
