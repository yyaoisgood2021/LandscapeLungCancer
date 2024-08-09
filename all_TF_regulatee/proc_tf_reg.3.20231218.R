library(stringr)
library(data.table)
library(patchwork)
library(cowplot)
library(dplyr)
library(ComplexHeatmap)
library(tidyr)
# library(tidyverse)
library(ggsignif)
library(gplots)
library(cluster)
library(pheatmap)
library(heatmaply)
library(factoextra)
library(ggplotify)
library(cluster)
library(ggpubr)
library(rstatix)
library(preprocessCore)
library(multcomp)
library(ggplot2)
library(RColorBrewer)
library(magrittr)
library(tibble)



############################################################################################################
# process edges

id_dt <- read.csv('/stg3/data3/peiyao/work/20230922.Lina_lung/data/table_S1.csv')


cancer_ids <- id_dt[id_dt$Type=='LungAdenocarcinoma', ]$SampleID
normal_ids <- id_dt[id_dt$Type=='Non-neoplastic', ]$SampleID

network_folder_base <- '/stg3/data2/resource3/project/lung.epigenetics.landscape/final.results-share2Peiyao-2023/TAIJI/Network'
network_folder_save_base_0 <- '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.0'
network_folder_save_base_1 <- '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.1.new_new'
top_edge_perc <- 0.5

# load edge for each sample and convert to perc rank
for (i in cancer_ids) {
  dt_edge <- read.csv(file.path(network_folder_base, i, 'edges_combined.csv')) %>% as.data.frame 
  dt_edge <- dt_edge[order(dt_edge$weight, decreasing=T), ] 
  dt_edge <- dt_edge[1:(as.integer(top_edge_perc*dim(dt_edge)[1])), ]
  rownames(dt_edge) <- paste(i,'edge', (1:nrow(dt_edge)), sep='.')
  dt_edge$edge_expr_type <- i
  dt_edge <- dt_edge %>% mutate(percent_rank = rank(weight)/length(weight)) 
  print('--------')
  print(i)
  print(dt_edge %>% head)
  write.csv(dt_edge, file.path(network_folder_save_base_0, paste0('cancer.filtered_edges.',i,'.txt')), quote=F)
}
for (i in normal_ids) {
  dt_edge <- read.csv(file.path(network_folder_base, i, 'edges_combined.csv')) %>% as.data.frame 
  dt_edge <- dt_edge[order(dt_edge$weight, decreasing=T), ] 
  dt_edge <- dt_edge[1:(as.integer(top_edge_perc*dim(dt_edge)[1])), ]
  rownames(dt_edge) <- paste(i,'edge', (1:nrow(dt_edge)), sep='.')
  dt_edge$edge_expr_type <- i
  dt_edge <- dt_edge %>% mutate(percent_rank = rank(weight)/length(weight)) 
  print('--------')
  print(i)
  print(dt_edge %>% head)
  write.csv(dt_edge, file.path(network_folder_save_base_0, paste0('normal.filtered_edges.',i,'.txt')), quote=F)
}


sig_TF <- c('ALX4', 'ARID3B', 'BACH2', 'BCL6B', 'EMX1', 'FOXR2', 'HOXA3', 'HOXA5', 'KDM2B', 'KLF13', 'KLF4', 'LBX1', 'LHX3', 'MEIS1', 'PAX3', 'PAX6', 'RUNX2', 'SOX7', 'SP3', 'SRF', 'SRY', 'TBX22', 'TEAD4', 'TFAP2C', 'ZBTB7B', 'ZFX', 'ZNF254', 'ZNF267', 'ZNF354B', 'ZNF610') 
# manually input sig TF here
# this time, we input TFs with log2FC between 0.3-0.5

# filter by significant TFs by this TF list
for (i in cancer_ids) {
  print(i)
  dt_edge <- read.csv(file.path(
    network_folder_save_base_0, 
    paste0('cancer','.filtered_edges.',i,'.txt')
  )) %>% as.data.frame()
  dt_edge <- dt_edge %>% dplyr::filter(X.START_ID %in% sig_TF) 
  print(dt_edge%>%head)
  write.csv(dt_edge, file.path(network_folder_save_base_1, 
                               paste0('cancer','.filtered_edges.',i,'.txt')
  ), quote=F)
}
for (i in normal_ids) {
  print(i)
  dt_edge <- read.csv(file.path(
    network_folder_save_base_0, 
    paste0('normal','.filtered_edges.',i,'.txt')
  )) %>% as.data.frame()
  dt_edge <- dt_edge %>% dplyr::filter(X.START_ID %in% sig_TF)
  print(dt_edge%>%head)
  write.csv(dt_edge, file.path(network_folder_save_base_1, 
                               paste0('normal','.filtered_edges.',i,'.txt')
  ), quote=F)
}





