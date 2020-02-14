import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == '__main__':
    curkey = None
    curdic = {}
    curcad = ''
    curlist = []
    
    for line in sys.stdin:
        llave, val = line.split(",")
        llave = llave.rstrip()
        if llave == curkey:
            curlist.append(int(val.rstrip()))
        else:
            if curkey is not None:
                for valor in sorted(curlist):
                    curcad = curcad + str(valor) + ','
                curcad = curcad[:-1]
                sys.stdout.write("{}       {}\n".format(curkey,curcad))
            curkey = llave
            curlist.clear()
            curcad = ''
            curlist.append(int(val.rstrip()))
    for valor in sorted(curlist):
        curcad = curcad + str(valor) + ','
    curcad = curcad[:-1]
    sys.stdout.write("{}       {}\n".format(curkey,curcad))