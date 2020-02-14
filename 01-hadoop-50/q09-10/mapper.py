import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#

if __name__ == "__main__":
    
    for line in sys.stdin:
    # Setting some defaults
        letra = ""
        fecha = ""
        valor = ""
        
        line = line.strip()
        splits = line.split("  ")
        letra = splits[0]
        fecha = splits[1]
        valor = splits[2]
 
        print(letra + '\t' + fecha + ',' + valor)