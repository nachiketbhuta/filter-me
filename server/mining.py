import pandas as pd
import numpy as np
from apyori import apriori

def mine():
    data = pd.read_csv('filter_association.csv')
    
    a, b = data.shape
    
    records=[]
    for i in range(0,10):
        records.append([str(data.values[i,j]) for j in range(0,10)])
    
    association_rules=apriori(records,min_support=0.20, min_confidence=0.50, min_lift=1.2, min_length=2)
    association_list=list(association_rules)
    
    listRules = [list(association_list[i][0]) for i in range(0,len(association_list))]
    final_list=[]
    final_list.extend(listRules[102])
    final_list.extend(listRules[115])
    final_list.extend(listRules[109])
    final_list=list(set(final_list))
    return(final_list)