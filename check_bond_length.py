import math
import sys
from math import sqrt

def check_distances(name, atom_names, coords, connections):

	for connection in connections:

		x1 = coords[connection[0]-1][0]
		x2 = coords[connection[1]-1][0]
		y1 = coords[connection[0]-1][1]
                y2 = coords[connection[1]-1][1]
		z1 = coords[connection[0]-1][2]
                z2 = coords[connection[1]-1][2]


		distance = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2))

		if (distance < 0.94):
	
			print name, atom_names[connection[0]-1], x1, y1, z1, atom_names[connection[1]-1], x2, y2, z2, distance

	return;

def main():

	filename = sys.argv[1]

	mol2_file = open(filename,'r')
	lines = mol2_file.readlines()
	mol2_file.close()

	for line in lines:

		linesplit = line.split()
		if (len(linesplit) == 3) and (linesplit[1] == "Name:"):
			name = linesplit[2]
			atom_names = []
			coords = []
			connections = []

		if (len(linesplit) == 9) and (linesplit[8] != "ROOT"):

			atom_names.append(linesplit[1])
                        #print "in 9 loop"
			coord = []

			coord.append(float(linesplit[2]))
			coord.append(float(linesplit[3]))
			coord.append(float(linesplit[4]))

			coords.append(coord)

		if (len(linesplit) == 4) and (linesplit[0] != "##########"):

			connection = []
                        #print "in 4 loop"
			connection.append(int(linesplit[1]))
			connection.append(int(linesplit[2]))

			connections.append(connection)
                        
		if (line.strip() == "@<TRIPOS>SUBSTRUCTURE"):

			check_distances(name, atom_names, coords, connections)

	return;

main()
