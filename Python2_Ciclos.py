# Python con Ciclos

# Importamos cosas
import numpy as num
import time as time

# Definimos variable universal
global factoriales


num = float(input())
contador = 0

# Sucesion - Primeros diez digitos ciclo A
for i in range (1, 11):
    print(i)
    i = i + 1

# Sucesion - Primeros diez digitos ciclo B

t = 1

while (t <= 10):
    print(t)
    t = t + 1

# Fibonacci Iterativo

def fibonacci_iterativo(n):
    a = 1
    b = 1
    if n == 1:
        print('0')
    elif n == 2:
        print('0','1')
    else:
        print('0')
        print(a)
        print(b)
        for i in range(n-3):
            total = a + b
            b = a
            a = total
            print(total)
            
fibonacci_iterativo(5);

time.sleep(1)