#!/usr/bin/env python

import os, sys
import numpy as np
import matplotlib.pyplot as plt


# Get the total number of generations from the CMD line
number_of_gen=int(sys.argv[1])+1
input_file=sys.argv[2]
figure_name=sys.argv[3]
#axis_label=sys.argv[4]

#http://matplotlib.org/api/pyplot_api.html?highlight=plot#matplotlib.pyplot.plot
#http://stackoverflow.com/questions/22408237/named-colors-in-matplotlib

#--------------------

print_file = open("all_data.%s.%s.%s.csv" % (figure_name, input_file, str(number_of_gen)), "w")

#Print figure
plt.figure(figsize=(12,10))
ax = plt.subplot(111)
#---------------------------
# Load Suvivor dat
for i in range(0, number_of_gen):
   print i
   #Open the correct file
   file=open("%s%s.dat" % (input_file, i))
   lines = file.readlines()
   file.close()
 
   #Clear vectors
   values=[]
   gen=[]


   for score in lines:
      values.append(score)
      gen.append(i)
   data=np.array(values)

   if data.size > 1:
      datamed=np.median(data)
      dataavg= np.average(data)
      datastd=np.std(data)
      datamin=np.min(data)

   # Save DATA
   print_file.write("system,%s,desc,%s,gen,%s,mean,%s,std,%s,median,%s\n" % (figure_name, input_file, str(i), str(dataavg), str(datastd), str(datamed)))        

   if ((dataavg - datastd) < datamin):
      #print datastd, datamin-dataavg
      #print np.abs(datamin-dataavg)
      #ax.errorbar(i, dataavg, yerr=np.array([[np.abs(datamin-dataavg), datastd]]), color='darkorange')
      ax.errorbar(i, dataavg, yerr=[[np.abs(datamin-dataavg)], [datastd]], color='darkorange')
   else:
      ax.errorbar(i, dataavg, datastd, color='darkorange')
   #ax.plot(i, dataavg, '.k', fillstyle='full', markeredgewidth=0.2)
   if len(data) > 50:
      topavg=np.average(data[:50])
      topstd=np.std(data[:50])
      topmin=np.min(data[:50])

      if ((topavg - topstd) < topmin):
         ax.errorbar(i, topavg, yerr=[[np.abs(topmin-topavg)], [topstd]], color='blue')
      else:
         ax.errorbar(i, topavg, topstd, color='blue')
      ax.plot(i, topavg, 'pc', linewidth=0, fillstyle='full', markeredgewidth=0.2)
   #ax.scatter(gen[:50], data[:50], color='blue', marker='v')
   #ax.scatter(i, datamed, color='orange')
   #plt.ylim(-110,-10)
   plt.xlim(-5,number_of_gen+4)
   plt.xlabel("Generation Number", size=20)
   #plt.ylabel("%s" % (input_file))
   plt.ylabel("Survivor Fitness Score", size=20)
   #plt.ylabel("Overall Fitness Score")
   #plt.title(figure_name)
   plt.xticks(fontsize=18)
   plt.yticks(fontsize=18)
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)
ax.yaxis.set_ticks_position('left')
ax.xaxis.set_ticks_position('bottom')

print_file.close()
#plt.show()
plt.savefig("figure_"+figure_name+"_"+input_file+'_std_assymetric.png')
plt.close()
quit()
