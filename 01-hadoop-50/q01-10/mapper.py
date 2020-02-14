import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
#!/usr/bin/env python3
if __name__ == "__main__":
    for line in sys.stdin:
    # Setting some defaults
        credit = ""
        
        line = line.strip()
        splits = line.split(",")
        credit = splits[2]
        #print(str(len(splits)) + ' :: ' + line)
        #if len(splits) != 4: # Transactions have more columns than users
         #   user_id = splits[2]
          #  product_id = splits[1]
           # sales = splits[3] 
        #else:
         #   user_id = splits[0]
          #  location = splits[3] 
        print(credit + '\t1' )