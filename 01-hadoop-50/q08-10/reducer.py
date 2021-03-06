import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#
##
## Esta funcion reduce los elementos que
## tienen la misma clave
##

if __name__ == '__main__':
    key_val = {}
    maximo = 0
#Partitoner
    for line in sys.stdin:
        line = line.strip()
        key, val = line.split('-')

        if key in key_val:
            key_val[key].append(int(val))
        else:
            key_val[key] = []
            key_val[key].append(float(val))
        
    #print(key_val['retraining'])
    #print(key_val.keys())
#Reducer
    for key in key_val.keys():
        maximo = sum(key_val[key]) 
        print(key + '\t' +str(maximo))