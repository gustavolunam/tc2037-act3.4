# Programa de Python para probar estatutos boleanos

import time

global z
 
# Caso A
x = float(input())
y = 10
print(bool(x == y))
 
# Caso B
x = None
print(bool(x))
 
# Caso C
a = true
b = false
print(bool(a == y))

# Caso D

print(bool(10 % 4 == 0))
print(bool(19 <= 20))
print(bool(34 != 35)) 
 
# Caso E

print(not(not(bool(5 + 5 - 10 == 0))))

time.sleep(1)

# Conversion de boleano a decimal

lst = []

l = int(input("Valor en boleano: "))

while (len(lst) < l):
    sR = "Ingresa el valor de la posición " + str(len(lst)) + ": "
    v = int(input(sR))
    if (v == 0 or v == 1):
        lst.append(v)
    else:
        print("Valor inválido, ingresa 0 o 1")
        time.sleep(1)
     
r = 0
cont = 0

for e in lst:
    r = r + pow(2,cont)*e
    cont = cont + 1
    
print("El resultado es: " + str(r))

if (r % 2 == 0 and r > 10):
    print("Número par mayor a 10")
 