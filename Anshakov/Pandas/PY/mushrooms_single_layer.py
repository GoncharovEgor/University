#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import seaborn as sns


# In[2]:


mushrooms = pd.read_csv(r'C:\Users\Elijah\Downloads\mushrooms.csv')
mushrooms = mushrooms.sort_values(by='class')


# In[3]:


X = mushrooms.drop('class', axis=1)
y = mushrooms['class']


# In[4]:


y = pd.get_dummies(y.to_frame(), drop_first=True).rename(columns={'class_p': 'poisonous'})


# In[5]:


X = pd.get_dummies(X, drop_first=True)


# In[6]:


y = y * 2
y = y.astype(int)
y = y - 1

X = X * 2
X = X.astype(int)
X = X - 1


# In[7]:


# данные готовы (значения '?' остались нетронутыми)


# In[8]:


# внутренний код

def Work(X,W):
    S=np.dot(X,W)
    Y=np.sign(np.sign(S)-0.5)
    return Y

def Correction(X,Y,D,W,eta):
    Delta=D-Y    
    W+=eta*np.dot(X.T,Delta)
    return Delta, W

def Train(df_input, df_output, eta, MaxIter):
    I=len(df_input.columns)
    O=len(df_output.columns)
    W=np.zeros((I,O))
    N=len(df_input.index)
    Iter=0
    Success=True
    StopCondition=False
    while not StopCondition:
        StopCondition = True
        for i in range(N):
            X=np.array(df_input.iloc[i])
            X.shape=(1,I)
            D=np.array(df_output.iloc[i])
            D.shape=(1,O)
            Y=Work(X,W)
            Delta,W=Correction(X,Y,D,W,eta)
            StopCondition &= (np.sum(np.absolute(Delta))==0)    
        Iter+=1
        if Iter>MaxIter:
            Success=False
            break
    return W, Success, Iter

def Test(df_input,df_output,W):
    I=len(df_input.columns)
    O=len(df_output.columns)
    N=len(df_input.index)
    K=0
    for i in range(N):
        X=np.array(df_input.iloc[i])
        X.shape=(1,I)
        D=np.array(df_output.iloc[i])
        D.shape=(1,O)
        Y=Work(X,W)
        Delta=D-Y
        if np.sum(np.absolute(Delta))!=0:
            K+=1
    return K


# In[9]:


from sklearn.model_selection import train_test_split

MaxIter=1000 #int(input('maximum number of iterations: '))
eta=0.3 #float(input('learning rate: '))
df_train_input, df_test_input, df_train_output, df_test_output = train_test_split(X, y, test_size=0.2, random_state=0)
W, Success, Iter = Train(df_train_input, df_train_output, eta, MaxIter)
if Success:
    print('fine')
else:
    print('unsuccessful learning')


# In[10]:


print(Iter,'iterations')
K = Test(df_test_input, df_test_output, W)
print(K, 'errors')

