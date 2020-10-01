import sys

### This script reads in a text file argv1 and parses ###
### through all the multimol2 files to grab about a   ### 
### percentage argv2 of those said molecules.         ###
### Run Example: python script file.txt 0.001         ###
 
counter = 0

inputfilename = sys.argv[1]
percentage = sys.argv[2]

f = open(inputfilename, 'r')

for line in f:
	print line
	#split file.txt by , 
	a,b= line.split(":")
	print a 
	name = 'reduced_' + str(a)
	outfile = open(name, 'w')
	print b

	#calculate how many molecules to take from that file
	c = (int(b)*float(percentage))
	d = int(c)
	print d
	
	#open that specific mol2 file
	moleculesfile = open(a, 'r')
	counter = 0
	for lines in moleculesfile:
		if (counter < d) and ("@<TRIPOS>MOLECULE" in lines):
			counter += 1
			#print "if"
			outfile.write(lines)
			if (counter == d) and ("@<TRIPOS>MOLECULE" in lines):
				#print "nested if"
				#GTFO
				outfile.close()
				#moleculesfile.close()
		elif (counter < d) and ("@<TRIPOS>MOLECULE" not in lines):
			#print "elif loop"
			outfile.write(lines)


