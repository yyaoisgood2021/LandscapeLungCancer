#!/bin/bash


for chip_name in "H3K27ac" "H3K27me3" "H3K4me1" "H3K4me3" "H3K9me3"
do
	sbatch ./01.intersect_pks.chip.0.sh $chip_name
done



sbatch ./01.intersect_pks.genes.0.sh


