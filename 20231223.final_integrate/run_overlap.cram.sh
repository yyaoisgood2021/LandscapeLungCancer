#!/bin/bash

# this script run `bedtools intersect` on one individual signal feature (cRAM)


coord_file="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20231223.final_integrate/01.gene_prom_body_loc.bed/all_genes.hg19.bed"

feature_bed_folder=/stg3/data3/peiyao/work/20230922.Lina_lung/results/EP300/ram_data
save_folder_base="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20231223.final_integrate/11.overlaps.cRAM"
save_fname_base="overlap"

mkdir -p ${save_folder_base}

for feature in "shared.final_merged" "spec.cancer" "spec.normal"
do
	feature_bedgraph_file="${feature_bed_folder}/${feature}.bed" 
	bedtools intersect -wao -a ${coord_file} -b ${feature_bedgraph_file} > ${save_folder_base}/${save_fname_base}.${feature}.txt 
	# make sure all coordinates are under the same assembly hg19
done


echo "done!"










