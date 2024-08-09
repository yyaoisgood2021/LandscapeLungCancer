#!/bin/bash

# this script run `bedtools intersect` on one individual signal feature (chip-seq)


coord_file="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20231223.final_integrate/01.gene_prom_body_loc.bed/all_genes.hg19.bed"

feature_bed_path="/stg3/data3/peiyao/work/20230922.Lina_lung/data/episig_sections/lung.adj.norm.sel2.episig.clusters.add.section.txt"
save_folder_base="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20231223.final_integrate/12.overlaps.episig"
save_fname_base="overlap"


mkdir -p ${save_folder_base}

bedtools intersect -wao -a ${coord_file} -b ${feature_bed_path} > "${save_folder_base}/${save_fname_base}.episig_section.txt" 
# make sure all coordinates are under the same assembly hg19


echo "done!"









