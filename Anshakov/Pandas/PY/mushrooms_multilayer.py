#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import seaborn as sns


# In[2]:


data = pd.read_csv(r'C:\Users\Elijah\Downloads\mushrooms.csv')
data = data.sort_values(by='class')


# In[3]:


X = data.drop('class', axis=1)  # средние значения данных
y = data['class']


# In[4]:


y = pd.get_dummies(y.to_frame(), drop_first=True)


# In[5]:


X = pd.get_dummies(X, columns=X.columns, drop_first=True)


# In[6]:


# данные готовы (значения '?' остались нетронутыми)


# In[7]:


# внутренний код

import numpy.random as rnd

def Init_Net(df_input, df_output, K):
    I=len(df_input.columns)
    O=len(df_output.columns)
    d=I-O
    delta=d//(K+1)
    l=[I] 
    for i in range(K):
        l.append(I-(i+1)*delta)
    l.append(O)
    LW=[]
    for i in range(K+1):
        W=rnd.uniform(0,0.1,(l[i],l[i+1]))
        LW.append(W)
    return LW

def Sigmoid(S,a):
    return 1/(1+np.exp(-a*S))

def Work_Item(X,W,a):
    S=np.dot(X,W)
    Y=Sigmoid(S,a)
    return Y

def Work(X,LW,a):
    K=len(LW)
    LY=[X]
    for i in range(K):
        Y=Work_Item(X,LW[i],a)
        LY.append(Y)
        X=Y
    return LY

def Correction(LY,LW,D,eta,a):
    K=len(LW)
    for k in list(range(K+1))[::-1][:-1]:
        if k==K:
            error=t=D-LY[k]
        else:
            t=np.dot(Delta,LW[k].T)
        Delta=a*t*LY[k]*(1-LY[k])
        LW[k-1]+=eta*np.dot(LY[k-1].T,Delta)
    return LW, error

def Train(df_input, df_output, KIntra, a, eta, MaxIter, epsilon):
    I=len(df_input.columns)
    O=len(df_output.columns)
    LW=Init_Net(df_input, df_output, KIntra)
    Iter=0
    N=len(df_input.index)
    Success=True
    StopCondition=False
    while not StopCondition:
        ErrorEnergy=[]
        for i in range(N):
            X=np.array(df_input.iloc[i])
            X.shape=(1,I)
            D=np.array(df_output.iloc[i])
            D.shape=(1,O)
            LY=Work(X,LW,a)
            LW,error=Correction(LY,LW,D,eta,a)
            ErrorEnergy.append(0.5*np.sum(error**2))
        AvgErrorEnergy=np.mean(np.array(ErrorEnergy))
        Iter+=1
        StopCondition=(AvgErrorEnergy<epsilon)
        if Iter>MaxIter:
            Success=False
            break
    return LW, Success, Iter
    
def Test(df_input,df_output,KIntra,a,LW,epsilon):
    I=len(df_input.columns)
    O=len(df_output.columns)
    N=len(df_input.index)
    K=len(LW)
    KError=0
    for i in range(N):
        X=np.array(df_input.iloc[i])
        X.shape=(1,I)
        D=np.array(df_output.iloc[i])
        D.shape=(1,O)
        LY=Work(X,LW,a)
        Y=LY[K]
        error=D-Y
        if 0.5*np.sum(error**2)>=epsilon*5:
            KError+=1
    return KError


# In[8]:


from sklearn.model_selection import train_test_split

MaxIter=1000 #int(input('maximum number of iterations: '))
KIntra=1 #int(input('number of intermediate layers: '))
eta=0.3 #float(input('learning rate: '))
epsilon=0.015 #float(input('epsilon: '))
a=1 #float(input('parameter a: '))
df_train_input, df_test_input, df_train_output, df_test_output = train_test_split(X, y, test_size=0.2, random_state=0)
LW, Success, Iter = Train(df_train_input, df_train_output, KIntra, a, eta, MaxIter, epsilon)
if Success:
    print('fine')
else:
    print('unsuccessful learning')


# In[9]:


print(Iter, 'iterations')
KError = Test(df_test_input, df_test_output, KIntra, a, LW, epsilon)
print(KError, 'errors')

