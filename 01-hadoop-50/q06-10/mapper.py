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
    for i in sorted(caracteres):
        linea=[]
        maximo = 0
        minimo = 100
        for j in d:
            if j[0] == i: 
                if (float(j[2]) > maximo):
                    maximo = float(j[2])
                if (float(j[2]) < minimo):
                    minimo = float(j[2])
        
        result = i + ' ' + str(maximo) + '  ' + str(minimo)
        print(result)

