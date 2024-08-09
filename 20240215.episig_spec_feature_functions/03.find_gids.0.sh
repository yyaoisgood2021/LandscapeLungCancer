#!/bin/bash


chip_name=$1
epicls=$2
pk_type=$3

dt_folder="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20240215.episig_spec_feature_functions/02.episig_spec_features"
dt_path="${dt_folder}/EpiSig.cls_${epicls}/${chip_name}/${pk_type}.txt"


if [ -f "$dt_path" ]; then
    echo "${dt_path}\nFile exists."
    
    # this is gene coord gencode bed file
    feature_bed_path="/stg3/data3/peiyao/data/gencode/gencode.hg19.all_gene_names.organized.bed"
    
    sv_folder="/stg3/data3/peiyao/work/20230922.Lina_lung/results/20240215.episig_spec_feature_functions/03.episig_features_2_geneid_overlaps"
    sv_folder="${sv_folder}/EpiSig.cls_${epicls}/${chip_name}"
    mkdir -p ${sv_folder}
    sv_path="${sv_folder}/${pk_type}.hg19.bed"

    bedtools intersect -wao -a ${dt_path} -b ${feature_bed_path} > "$sv_path" 


else
    echo "File does not exist."
fi



echo "done"