# -*- coding: utf-8 -*-
"""
Created on Sat Feb  1 11:48:14 2020

@author: priya
"""
from spacy.matcher import PhraseMatcher
from io import StringIO
import pandas as pd
from collections import Counter
import en_core_web_sm


nlp = en_core_web_sm.load()

def loggingStart(item):
    print(f'=================STARTING {item}=====================')

def loggingEnd(item):
    print(f'=================END {item}=====================')

def create_profile(text):
    name=text[1]
    text.remove(text[0])
    text.remove(text[1])
    text = str(text)
    text = text.lower()
    #below is the csv where we have all the keywords, you can customize your own
    loggingStart("CLASSIFYING KEYWORDS")
    keyword_dict = pd.read_csv('data.csv',encoding="ISO-8859-1")
    loggingEnd("CLASSIFYING KEYWORDS")
    loggingStart("CLASSIFYING ML BASED WORDS")
    ML_words = [nlp(text) for text in keyword_dict['Machine Learning'].dropna(axis = 0)]
    loggingEnd("CLASSIFYING ML BASED WORDS")
    loggingStart("CLASSIFYING DL BASED WORDS")
    DL_words = [nlp(text) for text in keyword_dict['Deep Learning'].dropna(axis = 0)]
    loggingEnd("CLASSIFYING DL BASED WORDS")
    loggingStart("CLASSIFYING PYTHON BASED WORDS")
    python_words = [nlp(text) for text in keyword_dict['Python Language'].dropna(axis = 0)]
    loggingEnd("CLASSIFYING PYTHON BASED WORDS")
    loggingStart("CLASSIFYING WEB BASED WORDS")
    web_words = [nlp(text) for text in keyword_dict['Web'].dropna(axis = 0)]
    loggingEnd("CLASSIFYING WEB BASED WORDS")
    loggingStart("CLASSIFYING CYBER SECURITY BASED WORDS")
    security_words=[nlp(text) for text in keyword_dict['Cyber security'].dropna(axis = 0)]
    loggingEnd("CLASSIFYING CYBER SECURITY WORDS")

    loggingStart("MATCHING")
    matcher = PhraseMatcher(nlp.vocab)
    
    matcher.add('ML', None, *ML_words)
    matcher.add('DL', None, *DL_words)
    matcher.add('Web', None, *web_words)
    matcher.add('Python', None, *python_words)
    matcher.add('CS', None, *security_words)
    doc = nlp(text)
    
    d = []  
    matches = matcher(doc)
    for match_id, start, end in matches:
        rule_id = nlp.vocab.strings[match_id]  # get the unicode ID, i.e. 'COLOR'
        span = doc[start : end]  # get the matched slice of the doc
        d.append((rule_id, span.text))      
    loggingEnd("MATCHING")
    keywords = "\n".join(f'{i[0]} {i[1]} ({j})' for i,j in Counter(d).items())
    #print(str(keywords))
    ## convertimg string of keywords to dataframe
    loggingStart("CONVERT TO DATAFRAMES")
    df = pd.read_csv(StringIO(keywords),names = ['Keywords_List'])
    df1 = pd.DataFrame(df.Keywords_List.str.split(' ',1).tolist(),columns = ['Subject','Keyword'])
    df2 = pd.DataFrame(df1.Keyword.str.split('(',1).tolist(),columns = ['Keyword', 'Count'])
    df3 = pd.concat([df1['Subject'],df2['Keyword'], df2['Count']], axis =1) 
    df3['Count'] = df3['Count'].apply(lambda x: x.rstrip(")"))
    label=list(df3['Subject'])
    loggingEnd("CONVERT TO DATAFRAMES")
    count={}
    x=set(label)
    for i in x:
        y=label.count(i)
        count.update({y:i})
    final=max(list(count.keys()))
    
    data={'Candidate Name':name,'Subject':[count[final]],'Count':[final]}
    
    df4=pd.DataFrame(data)
    return(df4)

def classifier():
    #input_text= [['A','rnn','cnn','django','keras'],['B','svm','Linear Regression','flask']]
    columns=['Candidate Name','Subject','Count']
    data=pd.DataFrame(columns=columns)
    df=pd.read_csv('input.csv')
    for row in df.itertuples():
        x=create_profile(list(row))
        data=data.append(x,ignore_index=True)
    return(data)

def recommendation(data,input_data):
    input_data=create_profile(input_data)
    input_data=str(list(input_data['Subject']))
    input_data=input_data.rstrip("']")
    input_data=input_data.lstrip("['")
    query='Subject=="'+input_data+'"'
    data.query(query,inplace=True)
    data.sort_values(by=['Count'], inplace=True, ascending=False)
    names = list(data['Candidate Name'])
    return names


#d=classifier()
#print(d)
# d=classifier()
# input_data=['B','svm','Linear Regression','flask']
# recommendation(d,input_data)

    
    
    
    

