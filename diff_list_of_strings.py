import sys

## Written by LPrentis                          ##
## September 2019                               ##
## This script compares two files containing    ##
## strings to determine what is not overlapping ##
 
#s = ['a','b','c']   
#f = ['a','b','d','c']  
s = sys.argv[1]
f = sys.argv[2]

inputfiles = open(s, 'r')
inputfilef = open(f, 'r')
ss= set(inputfiles)  
fs =set(inputfilef)  

#print ss.intersection(fs)   
#   **set(['a', 'c', 'b'])**  
#print ss.union(fs)        
#   **set(['a', 'c', 'b', 'd'])**  
print ss.union(fs)  - ss.intersection(fs)   
#   **set(['d'])**
