#!/bin/bash

# this script run `bedtools intersect` on one individual signal feature (chip-seq)


coord_file="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20231223.final_integrate/01.gene_prom_body_loc.bed/all_genes.hg19.bed"

feature_bed_folder="/stg3/data3/peiyao/work/20230922.Lina_lung/results/chipseq/feature_bed.diffbind_results"
save_folder_base="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20231223.final_integrate/10.overlaps.chipseq"
save_fname_base="overlap"


mkdir -p ${save_folder_base}

for feature in "H3K27ac" "H3K27me3" "H3K4me1" "H3K4me3" "H3K9me3"
do
	feature_bedgraph_file="${feature_bed_folder}/feature.${feature}.bed" 
	bedtools intersect -wao -a ${coord_file} -b ${feature_bedgraph_file} > ${save_folder_base}/${save_fname_base}.${feature}.txt 
	# make sure all coordinates are under the same assembly hg19
done











