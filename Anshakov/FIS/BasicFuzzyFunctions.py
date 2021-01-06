import numpy as np

def Trap(x,a,b,c,d):
    if a<=x<=b:
        return (x-a)/(b-a)
    elif b<=x<=c:
        return 1
    elif c<=x<=d:
        return (d-x)/(d-c)
    else:
        return 0
    
def S(x,a,b):
    if a<=x<=b:
        return (x-a)/(b-a)
    elif x>=b:
        return 1
    else:
        return 0 
    
def Z(x,a,b):
    if x<=a:
        return 1
    elif a<=x<=b:
        return (b-x)/(b-a)
    else:
        return 0
    


def Centroid(X,Y):
    X=np.array(X)
    Y=np.array(Y)
    return sum(X*Y)/sum(Y)

def FirstMax(X,Y):
    X=np.array(X)
    Y=np.array(Y)
    mY=max(Y)
    m=min(np.where(Y==mY)[0])
    return X[m]

def LastMax(X,Y):
    X=np.array(X)
    Y=np.array(Y)
    mY=max(Y)
    m=max(np.where(Y==mY)[0])
    return X[m]

def AvgMax(X,Y):
    X=np.array(X)
    Y=np.array(Y)
    mY=max(Y)
    M=np.where(Y==mY)[0]
    A=[X[i] for i in M]
    A=np.array(A)
    return np.mean(A)
