import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#

if __name__ == "__main__":
    d=[]
    chars = []
    for line in sys.stdin:
    # Setting some defaults
       
        line = line.strip()
        splits = line.split("  ")
        
        d.append(splits)
    #print(d)
        
        
    e = []    
    for s in d:
        #print(s[0])
        e.append(s[0])
    caracteres = set(e)    
    #print(sorted(caracteres))
    linea=[]
    minimos=[]
    maximos=[]
    result = ''
    suma = 0
    cont = 0
    for i in sorted(caracteres):
        linea=[]
        suma = 0
        cont = 0
        for j in d:
            if j[0] == i: 
                suma += int(j[2])
                cont += 1
        result = i + '\t\t' + str(suma/1) + '-' + str(suma/cont) 
        print(result)
