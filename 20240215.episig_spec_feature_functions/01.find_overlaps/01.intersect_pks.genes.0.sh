#!/bin/bash

chip_name="DEG"

# hg19 bed file for DEG
coord_file="/stg3/data3/peiyao/work/20230922.Lina_lung/data/DESEQ/DEG_coord.hg19.bed"


# episig_path
feature_bed_path="/stg3/data3/peiyao/work/20230922.Lina_lung/data/episig_sections/lung.adj.norm.sel2.episig.clusters.add.section.txt"


save_folder_base="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20240215.episig_spec_feature_functions/01.overlaps"
save_fname_base="overlap_episig"


mkdir -p ${save_folder_base}

bedtools intersect -wao -a ${coord_file} -b ${feature_bed_path} > \
    "${save_folder_base}/${save_fname_base}.${chip_name}.hg19.txt" 
# make sure all coordinates are under the same assembly hg19


echo "done!"