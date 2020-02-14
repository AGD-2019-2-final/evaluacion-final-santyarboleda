import sys
#
# >>> Escriba el codigo del reducer a partir de este punto <<<
#
##
## Esta funcion reduce los elementos que
## tienen la misma clave
##

if __name__ == '__main__':
    key_val = {}
    cont = 0
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
    #print(key_val.keys())
#Reducer
    for key in key_val.keys():
        cont = len(key_val[key]) 
        print(key + '  ' +str(cont))
