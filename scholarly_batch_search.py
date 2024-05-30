#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 20 22:22:34 2023

@author: peiyaowu
"""

import numpy as np
import pandas as pd

from scholarly import scholarly

import time






#%% define a list 
tf_list = ['BACH1', 'OCT4']



#%% functions
def proc_searches_one_gene(one_gene : str, 
                           search_info : str = 'lung cancer',
                           top_X_reference : int = 10 
                           ):

    result = np.array([0,0,0,0])
    one_query = '{} {}'.format(one_gene, search_info) # search this keyword in google scholar
    print('search for {}'.format(one_query))
    
    # Perform the search
    search_query = scholarly.search_pubs(one_query)
    
    # Print the titles of the first "top_X" results
    for i in range(top_X_reference):
        try:
            this_query_dict = next(search_query)['bib']
            one_title, one_abstract = '', ''
            if 'title' in this_query_dict:     
                one_title = this_query_dict['title']
            if 'abstract' in this_query_dict:
                one_abstract = this_query_dict['abstract']
            one_tit_abs = one_title + '\n' + one_abstract

            
            result = result + proc_one_title(
                                one_tit_abs_lower = one_tit_abs.lower(),
                                gene_name_lower = one_gene.lower()
                                )
        except StopIteration:
            break
    # print("\n")
    return result


def proc_one_title(one_tit_abs_lower : str, 
                   gene_name_lower : str 
            
                       ):
    """
    this function processes the title and preview_of_abs of one paper, and return in some senarios
    1. gene is strongly supported (explicitly reported to be associated with disease), specifically, with NSCLC or non-small cell lung cancer
    2. gene is not explicitly reported, but is important in `lung cancers`
    3. gene is related to general cancers, not mentioning lung
    4. gene is not related to lung cancer or disease
    
    return a list of int, indicating whether or not 'key word' has been mentioned
    [IF_gene_mentioned, IF_general_cancer_mentioned, IF_lung_mentioned, IF_NSCLC_mentioned]
    """
    NSCLC_set = {'nsclc', 'non-small cell lung cancer', 'non small cell lung cancer', 'nonsmall cell lung cancer'
                 }
    general_set = {'cancer', 
                   'disease', 'diseases',  
                   'tumor', 'tumors'
        }

    IF_gene_mentioned = 0
    if (gene_name_lower in one_tit_abs_lower):
        IF_gene_mentioned = 1
        # print('gene name mentioned')
    if any(
            item.lower() in one_tit_abs_lower for item in NSCLC_set
            ):
        return np.array([IF_gene_mentioned, 1,1,1])
    if 'lung' in one_tit_abs_lower:
        return np.array([IF_gene_mentioned, 1,1,0])
    if any(
            item.lower() in one_tit_abs_lower for item in general_set
            ):
        return np.array([IF_gene_mentioned, 1,0,0])
    return np.array([IF_gene_mentioned, 0,0,0])
    
    

def proc_gene_list(gene_list : list):
    """
    return a value for each gene:
        0 -> 3 : no literature support -> strongly supported

    """
    result_all = []
    for gene_id in gene_list:
        time.sleep((2.5)) # sleep to avoid robot test
        result_cur = proc_searches_one_gene(gene_id, 
                                   'lung cancer',
                                   10)
        result_cur = np.array(result_cur)
        result_cur = np.array(result_cur>=1).astype(int)
        # print(result_cur)
        result_all.append(np.sum(result_cur)-1)
        
    return result_all

#%% test codes
proc_gene_list(tf_list)
    
    
    
    
    