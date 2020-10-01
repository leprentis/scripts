#!/usr/bin/env python

import os, sys
import numpy as np
import matplotlib.pyplot as plt


# Get the total number of generations from the CMD line
number_of_gen=int(sys.argv[1])+1
input_file=sys.argv[2]
figure_name=sys.argv[3]
#ymin=float(sys.argv[4])
#ymax=float(sys.argv[5])


#axis_label=sys.argv[4]

#http://matplotlib.org/api/pyplot_api.html?highlight=plot#matplotlib.pyplot.plot
#http://stackoverflow.com/questions/22408237/named-colors-in-matplotlib

#--------------------

#print_file = open("all_data.%s.%s.%s.txt" % (figure_name, input_file, str(number_of_gen)), "w")

#Print figure
fig = plt.figure(figsize=(10,6))
ax = plt.subplot(111)

#---------------------------
# For each path
i = 0
if i == 0:
   fit = []
   x = []
   # Load Suvivor dat
   for i in range(0, number_of_gen):
      #Open the correct file
      name=("%s%s.dat" % (input_file, i))
      if (os.path.isfile(name) and (os.stat(name).st_size > 0)):
	      file=open("%s%s.dat" % (input_file, i))
	      lines = file.readlines()
	      file.close()
	 
	      #Clear vectors
	      values=[]
	      gen=[]

	      for score in lines:
		 values.append(score)
		 gen.append(i)
	      data=np.array(values).astype(float)
	      datamed=np.median(data)
	      dataavg= np.average(data)
	      datastd=np.std(data)
	      datamin=np.min(data)
	      fit.append(datamin)
	      x.append(i)
      
   #print generation of min
   fitmin=np.min(fit)
   minindex=fit.index(min(fit))
   print("Gen,%s,Score,%s" % (str(minindex), str(fitmin)))

   color_plot = ['forestgreen', 'blue', 'blueviolet']
   ax.plot(x, fit, color_plot[0], linewidth="2.5")
   #plt.ylim(ymin,ymax)
   plt.xlim(-5,x[len(x)-1]+4)
   plt.xlabel("Generation Number", size=33)
   #plt.ylabel("%s" % (input_file))
   plt.ylabel("Top Survivor Fitness", size=33)
   #plt.ylabel("Overall Fitness Score")
   #plt.title(figure_name)
   plt.xticks(fontsize=30)
   plt.yticks(fontsize=30)
   ax.locator_params(axis='y', nbins=5)
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)
ax.yaxis.set_ticks_position('left')
ax.xaxis.set_ticks_position('bottom')
fig.subplots_adjust(bottom=0.2)
fig.subplots_adjust(left=0.2)

#print_file.close()
#plt.show()
plt.savefig("figure_"+figure_name+"_"+input_file+'_TOP_highresLARGER2.png', dpi=600, transparent=True)
plt.close()
quit()
