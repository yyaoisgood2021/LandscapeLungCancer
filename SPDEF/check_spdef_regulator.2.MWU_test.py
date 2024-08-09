import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import matplotlib
import os, sys

from scipy.stats import mannwhitneyu

id_dt = pd.read_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/data/table_S1.csv', index_col=0, )
# id_dt = id_dt[id_dt['Type']=='Non-neoplastic']
id_dt

N_can = (id_dt['Type']=='LungAdenocarcinoma').sum()
N_norm = (id_dt['Type']!='LungAdenocarcinoma').sum()


folder_1 = '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.0'

exist_in_X = 5 

# load and concat all edge files
for i, (f,t) in enumerate(id_dt.iloc[:].values):
    # print(i,f,t)
    if t=='LungAdenocarcinoma':
        dt_cur = pd.read_csv(os.path.join(
            folder_1, 'cancer.filtered_edges.{}.txt'.format(f)
            ), index_col=0)
        dt_cur['sample_type'] = 'cancer'
    elif t=='Non-neoplastic':
        dt_cur = pd.read_csv(os.path.join(
            folder_1, 'normal.filtered_edges.{}.txt'.format(f)
            ), index_col=0)
        dt_cur['sample_type'] = 'normal'
    else:
        raise KeyError('type should be normal or cancer')
    print(dt_cur.iloc[:3, ])
    if i==0:
        edge_dt = dt_cur.copy()
    else:
        edge_dt = pd.concat((edge_dt, dt_cur), ignore_index=True, )

edge_dt = edge_dt[['X.START_ID', 'X.END_ID', 'percent_rank', 'sample_type']]
print(edge_dt.iloc[:3, ])

hist_start_tf = []
hist_end_tf = []
hist_can_mean = []
hist_can_std = []
hist_can_exist = []
hist_norm_mean = []
hist_norm_std = []
hist_norm_exist = []

hist_pval = []

for (s,e), dt_ in edge_dt.groupby(['X.START_ID', 'X.END_ID']):
    if len(dt_)<exist_in_X:
        continue
    print(s,e,)

    # if len(hist_start_tf)>300:
    #     break

    hist_start_tf.append(s)
    hist_end_tf.append(e)
    dt_can_ = dt_[dt_['sample_type']=='cancer'].copy()
    dt_norm_ = dt_[dt_['sample_type']=='normal'].copy()
    
    can_val = list(dt_can_['percent_rank'])
    norm_val = list(dt_norm_['percent_rank'])

    hist_can_mean.append(np.mean(can_val))
    hist_can_std.append(np.std(can_val))
    hist_can_exist.append(len(can_val))

    hist_norm_mean.append(np.mean(norm_val))
    hist_norm_std.append(np.std(norm_val))
    hist_norm_exist.append(len(norm_val))

    can_val = can_val + [0]*(N_can-len(can_val))
    norm_val = norm_val + [0]*(N_norm-len(norm_val))

    _, p = mannwhitneyu(can_val, norm_val)
    hist_pval.append(p)


result_df = pd.DataFrame(
    {
    'start': hist_start_tf,
    'end': hist_end_tf,
    'mean_can':hist_can_mean,
    'std_can':hist_can_std,
    'exist_can':hist_can_exist,
    'mean_norm':hist_norm_mean,
    'std_norm':hist_norm_std,
    'exist_norm':hist_norm_exist,
    'pval':hist_pval,
    })

print(result_df.iloc[:3, ])

result_df.to_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/results/SPDEF/all_regulator.spdef.3_mwu_test.txt', 
                 sep='\t', index=None, )

# print(result_df[result_df['end']=='SPDEF'])