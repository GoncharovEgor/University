#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import seaborn as sns


# In[2]:


data = pd.read_csv(r'C:\Users\Elijah\Downloads\iris.csv', index_col=0)


# In[3]:


for i in range(4):
    data.iloc[:, i] = pd.cut(data.iloc[:, i], 3, labels=["low", "medium", "high"])


# In[4]:


data = pd.get_dummies(data, drop_first=True)


# In[5]:


data

