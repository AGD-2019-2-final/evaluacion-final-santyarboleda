import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#
import operator
import collections

##
## Esta funcion reduce los elementos que
## tienen la misma clave
##

if __name__ == '__main__':
    key_val = {}
    minimo = 0
    d=[]
    pos = -1
#Partitoner
    for line in sys.stdin:
        line = line.strip()
        key, val = line.split(',')
        pos += 1    
        
    #print(key, val)    
    #d[pos].append(int(val))
    #print(line)
        if key in key_val:
            key_val[key].append(int(val))
        else:
            key_val[key] = []
            key_val[key].append(int(val))
# Se ordena el diccionario    
    key_val2 = sorted(key_val.items(), key=operator.itemgetter(1))
    #print(key_val2)
    
    sorted_dict = collections.OrderedDict(key_val2)
    cont=0
    for key, val in sorted_dict.items():
        if cont <= 5: 
            print( key + '\t' + str(val[0]))
            cont += 1
        
            