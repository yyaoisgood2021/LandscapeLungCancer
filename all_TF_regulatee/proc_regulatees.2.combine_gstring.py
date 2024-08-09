#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""

this script does the same thing as spdef_s0.py, but on all significant TFs (>=1.5 only in this script)

@author: peiyaowu
"""

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import matplotlib
import os, sys

from scipy.stats import mannwhitneyu


save_folder = '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/sig_edges.FC_1.5'
os.makedirs(save_folder, exist_ok=True, )



def print_gnames_for_reactomePA(g_list):
    if len(g_list)>1:
        g_string = "'" + "', '".join(g_list) + "'"
        return g_string
    elif len(g_list)==1:
        return g_list[0]
    else:
        raise ValueError('must have at least 1 gene')



# ################################################################################################
# # load processed edge files from folder2

# result_df = pd.read_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.2.20231019/regulatee_list.pval_sig.txt', sep='\t',)
# # if load data from folder_2 or 'after_exist_check', then not all significant TFs (thresh=1.5) showed up,
# # but we have to use this file because it has `diff` values for edges

# # use exist_checked data
# # or we can try to use exist_not_checked data (do not use this)


# # load tf 
# tf_dt = pd.read_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/sig_TFs.FC_1.5.txt')
# tf_dt = tf_dt.iloc[:,2:] . copy()


# len(set(list(
#     result_df[result_df['start'].isin(tf_dt['TF'])] ['start']
#     ))) # 17 significant TFs

# len(set(list(
#     result_df[~result_df['start'].isin(tf_dt['TF'])] ['start']
#     ))) # 0 insignificant TFs



# result_df = result_df[['start', 'end', 'specificity', 'diff']].copy()
# result_df = result_df.merge(
#     tf_dt[['TF','log2FC']].copy(), 
#     how='left', left_on='start', right_on='TF')

# # result_df = result_df[['start', 'end', 'mean', 'std', 'log2FC']].copy()
# # result_df.fillna(0, inplace=True, )


# # increased TF
# increased_TF_list = set(list(result_df[result_df['log2FC']>0]['start'])) # 6
# decreased_TF_list = set(list(result_df[result_df['log2FC']<0]['start'])) # 11

thresh_list = [0.2+0.1*i for i in range(9)]
sv_list_all = [""]*len(thresh_list)
sv_list_pos = [""]*len(thresh_list)

for i, TF_up in enumerate(['ETV4', 'FEZF1', 'SIX1', 'SIX4', 'SPDEF', 'TFAP2D']):
    result_df_this_tf_of_interest = pd.read_csv(os.path.join(save_folder, 'sorted_edges.up_TF.{}.txt'.format(TF_up)), sep='\t', )
    # print(result_df_this_tf_of_interest)

    # print string that can be used for R pathway finder
    # print('------------------------------------------')
    # print(TF_up)
    # all
    g_list = list(result_df_this_tf_of_interest['end'])
    for j, thresh in enumerate(thresh_list):
        # find gstring for all
        g_list_cur = g_list[:int(thresh*len(g_list)+1)]
        g_string = print_gnames_for_reactomePA(g_list_cur+[TF_up])
        sv_list_all[j] = sv_list_all[j] + ", " + g_string
    
    # find gstring for pos subset
    result_df_this_tf_of_interest = result_df_this_tf_of_interest[result_df_this_tf_of_interest['diff']>0]
    g_list = list(result_df_this_tf_of_interest['end'])
    if len(g_list)==0:
        continue
    for j, thresh in enumerate(thresh_list):
        # find gstring for all
        g_list_cur = g_list[:int(thresh*len(g_list)+1)]
        g_string = print_gnames_for_reactomePA(g_list_cur+[TF_up])
        sv_list_pos[j] = sv_list_pos[j] + ", " + g_string
 

for (thresh, sv_list) in zip(thresh_list, sv_list_all):
    print(thresh, sv_list)
    
for (thresh, sv_list) in zip(thresh_list, sv_list_pos):
    print(thresh, sv_list)    
    
    
    # print('--------------')
    # print('all: ')
    # g_list = list(result_df_this_tf_of_interest['end'])
    # g_string = print_gnames_for_reactomePA(g_list+[TF_up])
    # print(g_string)
    # # top20%
    # print('--------------')
    # print('top20%: ')
    # g_list = g_list[:int(0.2*len(g_list)+1)]
    # g_string = print_gnames_for_reactomePA(g_list+[TF_up])
    # print(g_string)
    # # all_positive
    # print('--------------')
    # print('all_positive: ')
    # result_df_this_tf_of_interest = result_df_this_tf_of_interest[result_df_this_tf_of_interest['diff']>0]
    # g_list = list(result_df_this_tf_of_interest['end'])
    # g_string = print_gnames_for_reactomePA(g_list+[TF_up])
    # print(g_string)
    # # top20% of all_positive
    # if len(g_list)==0:
    #     continue
    # else:
    #     print('--------------')
    #     print('top20%_of_all_positive: ')
    #     g_list = g_list[:int(0.2*len(g_list)+1)]
    #     g_string = print_gnames_for_reactomePA(g_list+[TF_up])
    #     print(g_string)





# up_reg_dt = result_df_spdef[result_df_spdef['diff']>0].sort_values('diff', ascending=False, ).copy() # up regulate-weighted edges
# up_reg_dt = list(up_reg_dt['end'])
# up_reg_dt[:int(0.2*len(up_reg_dt))] # 28 genes