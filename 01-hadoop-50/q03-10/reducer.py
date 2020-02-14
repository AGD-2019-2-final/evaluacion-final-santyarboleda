import sys
#
# >>> Escriba el codigo del reducer a partir de este punto <<<
#
#! /usr/bin/python3

import sys
import operator
import collections
##
## Esta funcion reduce los elementos que
## tienen la misma clave
##

if __name__ == '__main__':
    key_val = {}
    minimo = 0
#Partitoner
    for line in sys.stdin:
        line = line.strip()
        key, val = line.split('\t')

        if key in key_val:
            key_val[key].append(int(val))
        else:
            key_val[key] = []
            key_val[key].append(int(val))
        
    #print(key_val['retraining'])
    #print(sorted(key_val.items(), key=operator.itemgetter(1)))
#Reducer
#    key_val2 = {}
    key_val2 = sorted(key_val.items(), key=operator.itemgetter(1))
#    print(key_val2)
    
    sorted_dict = collections.OrderedDict(key_val2)
    for key, val in sorted_dict.items():
        minimo = min(key_val[key]) 
        print(key + ',' + str(minimo))