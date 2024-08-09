import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import matplotlib
import os, sys

id_dt = pd.read_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/data/table_S1.csv', index_col=0, )
id_dt = id_dt[id_dt['Type']=='LungAdenocarcinoma']
id_dt

folder_1 = '/stg3/data3/peiyao/work/20230922.Lina_lung/results/taiji/edges.0'

exist_in_X = 5 

# load and concat all edge files
for i, f in enumerate(id_dt['SampleID']):
    print(f)
    dt_cur = pd.read_csv(os.path.join(
        folder_1, 'cancer.filtered_edges.{}.txt'.format(f)
        ), index_col=0)
    print(dt_cur.iloc[:3, ])
    if i==0:
        edge_dt = dt_cur.copy()
    else:
        edge_dt = pd.concat((edge_dt, dt_cur), ignore_index=True, )


hist_start_tf = []
hist_end_tf = []
hist_can_mean = []
hist_can_std = []

for (s,e), dt_ in edge_dt.groupby(['X.START_ID', 'X.END_ID']):
    # if len(dt_)<exist_in_X:
    #     continue
    # print(s,e,dt_)
    hist_start_tf.append(s)
    hist_end_tf.append(e)
    can_val = list(dt_['percent_rank'])
    hist_can_mean.append(np.mean(can_val))
    hist_can_std.append(np.std(can_val))


result_df = pd.DataFrame(
    {
    'start': hist_start_tf,
    'end': hist_end_tf,
    'mean':hist_can_mean,
    'std':hist_can_std,
    })

result_df

result_df.to_csv('/stg3/data3/peiyao/work/20230922.Lina_lung/results/SPDEF/all_regulator.spdef.2_no_exist_check.txt', 
                 sep='\t', index=None, )

print(result_df[result_df['end']=='SPDEF'])