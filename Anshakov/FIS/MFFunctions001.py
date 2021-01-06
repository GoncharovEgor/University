from BasicFuzzyFunctions import *

def mfSisG(x):
    return S(x, 80, 90)


def mfSisH(x):
    return Trap(x, 45, 75, 90, 95)


def mfSisM(x):
    return Trap(x, 40, 50, 60, 75)


def mfSisL(x):
    return Z(x, 40, 50)


def mfPisH(x):
    return S(x, 60, 80)


def mfPisM(x):
    return Trap(x, 30, 40, 60, 70)


def mfPisL(x):
    return Z(x, 20, 40)


def mfMisE(x):
    return S(x, 4.5, 4.8)


def mfMisG(x):
    return Trap(x, 3, 3.5, 4.5, 4.9)


def mfMisS(x):
    return Trap(x, 2.5, 2.8, 3.5, 4)


def mfMisB(x):
    return Z(x, 2, 2.8)


