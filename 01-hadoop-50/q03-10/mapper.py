import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
#!/usr/bin/env python3

if __name__ == "__main__":
    for line in sys.stdin:
    # Setting some defaults
        credit = ""
        amount = ""
        
        line = line.strip()
        splits = line.split(",")
        letra = splits[0]
        numero = splits[1]
 
        print(letra + '\t' + numero )