#!/stg3/data3/peiyao/miniconda3/envs/FCN/bin/python

import sys, os
import pandas as pd

deg_dt = pd.read_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/data/DESEQ/genelist.deg.twofold.pvalue.padj.1E-4.txt', 
    sep='\t', header=None, )

all_gene_coord_dt = pd.read_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/results/DEG/deg.all.organized.before_add_prom.txt',
                                sep='\t', )

all_gene_coord_dt = all_gene_coord_dt[all_gene_coord_dt['gene'].isin(deg_dt[0])]

all_gene_coord_dt[['chr','s','e','gene_name', 'log2FoldChange']].to_csv(
    '/stg3/data3/peiyao/work/20230922.Lina_lung/data/DESEQ/DEG_coord.hg19.bed', sep='\t', header=None, index=None, 
)


