#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""

ths file processes the edges | regulatees
from folder.1 : edges filtered by perc_rank >= 0.5 and start with sig TF of FC >=1.5 or <= 1/1.5

(1) find the reliable edges



@author: peiyaowu
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import matplotlib
import os, sys

from scipy.stats import mannwhitneyu
from scipy.stats import kruskal # do not use this test, only two types

id_path = '/stg3/data3/peiyao/work/20230922.Lina_lung/data/table_S1.csv'
edge_folder_1 = '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.1.new_new'
edge_folder_2 = '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.2'
edge_folder_2_20231019 = '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.2.20231019'


exist_in_X = 5 

N_cancer = 18
N_normal = 20


# load id list


id_dt = pd.read_csv(id_path, index_col=0)


# load and concat all edge files
for i, f in enumerate(os.listdir(edge_folder_1)):
    print(f)
    dt_cur = pd.read_csv(os.path.join(
        edge_folder_1,
        f
        ), index_col=0)
    ctype = f.split('.')[0]
    dt_cur['cell_type'] = ctype
    print(dt_cur.iloc[:3, ])
    if i==0:
        edge_dt = dt_cur.copy()
    else:
        edge_dt = pd.concat((edge_dt, dt_cur), ignore_index=True, )

print(len(edge_dt))
edge_dt # [1192867 rows x 8 columns]




# 202309
# find reliable edges if a particular TF exists in >= X samples
# result_history
hist_start_tf = []
hist_end_tf = []
hist_spec = []
hist_diff = [] # cancer - normal
hist_mwu_p = []
hist_can_mean = []
hist_can_std = []
hist_nor_mean = []
hist_nor_std = []
hist_in_can = []
hist_in_nor = []

for (s,e), dt_ in edge_dt.groupby(['X.START_ID', 'X.END_ID']):
    if len(dt_)<exist_in_X:
        continue
    print(s,e,dt_)
    can_val = list(dt_[dt_['cell_type']=='cancer']['percent_rank'])
    nor_val = list(dt_[dt_['cell_type']=='normal']['percent_rank'])
    hist_start_tf.append(s)
    hist_end_tf.append(e)
    hist_in_can.append(len(can_val))
    hist_in_nor.append(len(nor_val))
    if len(can_val)==0: # normal spec
        hist_spec.append('normal')
        hist_diff.append(-np.mean(nor_val))
        hist_mwu_p.append(0)
        hist_can_mean.append(0)
        hist_can_std.append(0)
        hist_nor_mean.append(np.mean(nor_val))
        hist_nor_std.append(np.std(nor_val))
    elif len(nor_val)==0: # cancer spec
        hist_spec.append('cancer')
        hist_diff.append(np.mean(can_val))
        hist_mwu_p.append(0)
        hist_can_mean.append(np.mean(can_val))
        hist_can_std.append(np.std(can_val))
        hist_nor_mean.append(0)
        hist_nor_std.append(0)
    else:
        hist_spec.append('shared')
        hist_diff.append(np.mean(can_val) - np.mean(nor_val))
        hist_mwu_p.append(mannwhitneyu(can_val, nor_val)[1])
        hist_can_mean.append(np.mean(can_val))
        hist_can_std.append(np.std(can_val))
        hist_nor_mean.append(np.mean(nor_val))
        hist_nor_std.append(np.std(nor_val))

result_df = pd.DataFrame(
    {
    'start': hist_start_tf,
    'end': hist_end_tf,
    'specificity': hist_spec,
    'diff': hist_diff,
    'pval': hist_mwu_p,
    'exist_in_cancer':hist_in_can,
    'mean_cancer':hist_can_mean,
    'std_cancer':hist_can_std,
    'exist_in_normal':hist_in_nor,
    'mean_normal':hist_nor_mean,
    'std_normal':hist_nor_std,
    })


result_df.to_csv(os.path.join(
    edge_folder_2, 'regulatee_list.all_info.new_new_sig_TF.txt'
    ), )

# # the next step is to filter by pval and diff

# # load from folder_2
# result_df = pd.read_csv(os.path.join(
#     edge_folder_2, 'regulatee_list.all_info.new_sig_TF.txt'
#     ), index_col=0, )


result_df = result_df[result_df['pval']<=0.05].copy() # [8302 rows x 11 columns] # still need to find a cutoff for weight_diff

result_df.to_csv(os.path.join(edge_folder_2_20231019, 'regulatee_list.pval_sig.new_new_sig_TF.txt'), sep='\t', index=None, )

















