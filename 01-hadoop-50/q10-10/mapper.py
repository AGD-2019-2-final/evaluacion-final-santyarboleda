import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        clave = ""
        valor = ""
        fecha = ""
        line = line.strip()
        splits = line.split("\t")
        clave= splits[0]
        cadena= splits[1]
        for i in cadena.split(","):
            sys.stdout.write("{},{}\n".format(i,clave))        