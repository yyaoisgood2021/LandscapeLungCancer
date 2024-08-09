#!/bin/bash


for chip_name in  "H3K27ac" "H3K27me3" "H3K4me1" "H3K4me3" "H3K9me3"
do
    for epicls in 1 2 3 4 5 6
    do
        for pk_type in "all" "cancer_high" "cancer_low"
        do
            sbatch "./03.find_gids.0.sh" $chip_name $epicls $pk_type
        done
    done


done

echo "done"