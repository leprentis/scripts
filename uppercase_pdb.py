#!/usr/bin/python
import sys, os


## Written by LPrentis                                  ##
## December 2019                                        ##
## This script reads in file and spits out upeprcase    ##

s = sys.argv[1]
r = sys.argv[2]

inputfiles = open(s, 'r')
this2 = inputfiles.read()

outputfile = open(r, 'w')

outputfile.write(this2.upper())

outputfile.close()

