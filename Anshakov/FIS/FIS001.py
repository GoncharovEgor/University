from BasicFuzzyFunctions import *
from MFFunctions001 import *

Score=Penal=Mark=0
SisG=SisH=SisM=SisL=PisH=PisM=PisL=MisE=MisG=MisS=MisB=0
MarkArray={x: 0 for x in range(20,51)}
       
       
def Fuzzification():
    global Score, Penal
    global SisG, SisH, SisM, SisL, PisH, PisM, PisL

    SisG = mfSisG(Score)
    SisH = mfSisH(Score)
    SisM = mfSisM(Score)
    SisL = mfSisL(Score)
    PisH = mfPisH(Penal)
    PisM = mfPisM(Penal)
    PisL = mfPisL(Penal)


def FuzzyInference():
    global SisG, SisH, SisM, SisL, PisH, PisM, PisL, MisE, MisG, MisS, MisB

    MisE = min(SisG, PisL)
    MisG = max(min(SisG, PisM), min(SisH, PisL))
    MisS = max(min(SisG, PisH), min(SisH, PisM), min(SisM, PisL))
    MisB = max(SisL, min(PisH, 1 - SisG))


def Composition():
    global MisE, MisG, MisS, MisB
    global MarkArray

    for i in range(20, 51):
        MarkArray[i] = max(min(mfMisE(i / 10), MisE), 
                    min(mfMisG(i / 10), MisG), 
                    min(mfMisS(i / 10), MisS), 
                    min(mfMisB(i / 10), MisB))



def Defuzzyfication():
    global Mark
    global MarkArray

    X=list(MarkArray.keys())
    Y=list(MarkArray.values())

    Mark = LastMax(X,Y) / 10


def Run():
    Fuzzification()
    FuzzyInference()
    Composition()
    Defuzzyfication()


def Init():
    global Score, Penal

    Score = float(input('Score = '))
    Penal = float(input('Penal = '))


def Terminate():
    global Mark

    print('Mark =', Mark)



def Main():
    Init()
    Run()
    Terminate()

if __name__=='__main__':
    Main()


# Function SoM(x():) As Integer
#     Dim zk As Integer
#     z = x(LBound(x))
#     k = LBound(x)
#     For i = LBound(x) + 1 To UBound(x)
#         If x(i) > z Then
#            z = x(i)
#            k = i
#         End If
#     Next
#     SoM = k
# End Function

# Function LoM(x():) As Integer
#     Dim zk As Integer
#     z = x(LBound(x))
#     k = LBound(x)
#     For i = LBound(x) + 1 To UBound(x)
#         If x(i) >= z Then
#            z = x(i)
#            k = i
#         End If
#     Next
#     LoM = k
# End Function

# Function Centroid(x():)
#     Dim NumDeni As Integer
#     Num = 0
#     Den = 0
#     For i = LBound(x) To UBound(x)
#         Num = Num + x(i) * i
#         Den = Den + x(i)
#     Next
#     Centroid = Num / Den
# End Function

