import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#

if __name__ == "__main__":
    for line in sys.stdin:
    # Setting some defaults
        line = line.strip()
        splits = line.split("  ")
        letra = splits[0]
        fecha = splits[1]
        year,month,date= fecha.split('-')
        print(month + '\t1'  )