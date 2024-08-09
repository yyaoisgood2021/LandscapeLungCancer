#!/bin/bash




coord_file=/stg3/data3/peiyao/work/20230922.Lina_lung/results/chipseq/gene_bed/GOI_txp_prom.hg19.bed
save_folder=/stg3/data3/peiyao/work/20230922.Lina_lung/results/chipseq/overlap_results
feature_bed_folder=/stg3/data3/peiyao/work/20230922.Lina_lung/results/chipseq/feature_bed.diffbind_results
save_fname_base="overlap"

mkdir -p ${save_folder}

for feature in H3K27ac H3K27me3 H3K4me1 H3K4me3 H3K9me3
do
	feature_bedgraph_file="${feature_bed_folder}/feature.${feature}.bed" 
	bedtools intersect -wao -a ${coord_file} -b ${feature_bedgraph_file} > ${save_folder}/${save_fname_base}.${feature}.txt # make sure all coordinates are under the same assembly hg19


done







