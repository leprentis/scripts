#!/usr/bin/env python

#This script is called by an mpi qsub script that will submit lots of jobs across processors with only one job. 


import os,sys
from mpi4py import MPI


#              Define Global Varialbes
#############################################################################
WORKDIR="/gpfs/projects/rizzo/leprentis/de-novo-sb2012"
DOCKHOME="/gpfs/home/leprentis/dock6.8_merge_06.14.2017"
TESTDIR="024_mpi_lep.de-novo.enhd.focused.mg"
#TESTDIR="024_test_lep.de-novo.debug_wrapper.mg"
#############################################################################



#This function reads the inputfile and returns the list system names x2
def get_systems(inputfile):
  #system_names array holder for the system names
  #parent_list  array holder for the parent jobs (the same as system_names)
  #line         the line in the job file
  system_names=[] 
  parent_list =[] 
  #check to see if the inputfile exists and quit if it doesn't
  if not os.path.isfile(inputfile):
    print " The file [ %s ] does not exist" % inputfile
    quit()
  #loop over each line and append the system name to the array
  tempfile=open(inputfile,"r")
  for line in tempfile:
    system_names.append(line.rstrip())
    parent_list.append(line.rstrip())
  tempfile.close()
  return system_names,parent_list



#This function is the main driver of the de novo mpi which assigns
#the parent and children jobs
def denovo_mpi(joblistfile):
  #comm        MPI object
  #rank        the processor's rank 
  #size        the total number of processors
  #maxchildren the max number of children (processors)
  #maxjobs     the max number of jobs each child will be assigned
  #systems     the array systems for the de novo calculation
  #parjentjobs the array of systems the parent will be assigned
  #tempjobs    the array that holds the systems assigned to each child
  #ranknum     the ranknumber of each of the children processors
  #dnjobs      the system name
  #parentjobsnum the initial jobs sent to parent prior to redistribution
  #numred      numerical difference between the parentjobs initially assigned and the maxjobs 
  #redistributejobs the bool used to determine if we need to redistribute jobs
  #childrenprocs the processors of the children that will be assigned maxjobs+1

  comm=MPI.COMM_WORLD
  rank=comm.Get_rank()
  size=comm.Get_size()
  maxchildren=size-1
 
  #if the parent the assign the children their tasks
  if rank==0:
    redistributejobs=False
    systems,parentjobs=get_systems(joblistfile)
    print systems,"\n",parentjobs
    maxjobs=len(systems)/size
    parentjobsnum=(len(systems)-(maxjobs*maxchildren))
    if parentjobsnum > maxjobs:
       redistributejobs=True
       numred=parentjobsnum-maxjobs
       childrenprocs=range(1,(numred+1))
    print "childrenprocs=", childrenprocs
    print "parentjobsnum=",parentjobsnum
    #print "maxjobs=",maxjobs # DEBUG
    #print "totalsize=",size  # DEBUG
    tempjobs=[]
    #print "parent_array=",len(parentjobs) # DEBUG

    #Loop over the children and assign each a job
    for ranknum in range(1,size):
        if redistributejobs:
           for dnjobs in systems:
             tempjobs.append(dnjobs)
             systems.remove(dnjobs) #each time it was added to tempjobs[] remove it
             if len(tempjobs)==(maxjobs+1):
               comm.send(tempjobs,dest=ranknum)
               for h in tempjobs:
                #print "removing system", h # DEBUG
                  parentjobs.remove(h)
               tempjobs=[]
               if ranknum==childrenprocs[-1]:
                   redistributejobs=False
               break #breaks out of for loop to give jobs to different processors instead of all jobs to one processor
        else:
           for dnjobs in systems:
             tempjobs.append(dnjobs)
             systems.remove(dnjobs) #each time it was added to tempjobs[] remove it
             if len(tempjobs)==maxjobs:
               comm.send(tempjobs,dest=ranknum)
               for h in tempjobs:
                #print "removing system", h # DEBUG
                   parentjobs.remove(h)
               tempjobs=[]
               break

    print "new_parent_array_len=",len(parentjobs)
    print "new_parent_array=",parentjobs    #DEBUG
    for j in parentjobs: #parent get jobs not assigned to the children
      os.chdir("%s/%s/%s" % (WORKDIR,j,TESTDIR))
      os.system("%s/bin/dock6 -i %s.de_novo.in -o %s.de_novo.out" % (DOCKHOME,j,j))
      os.system("%s/bin/dock6 -i rescore.in -o rescore.out" % (DOCKHOME))
      os.system("%s/bin/dock6 -i rescore_dump.in -o rescore_dump.out" % (DOCKHOME))
      os.chdir("%s" % (WORKDIR))

  else:
    recvMsg=comm.recv(source=0)
    if rank==1: 
        print "Hello from",rank,"totaljobs=",len(recvMsg),"\n" #DEBUG
        print recvMsg
    for i in recvMsg:
      os.chdir("%s/%s/%s" % (WORKDIR,i,TESTDIR))
      os.system("%s/bin/dock6 -i %s.de_novo.in -o %s.de_novo.out" % (DOCKHOME,i,i))
      os.system("%s/bin/dock6 -i rescore.in -o rescore.out" % (DOCKHOME))
      os.system("%s/bin/dock6 -i rescore_dump.in -o rescore_dump.out" % (DOCKHOME))
      os.chdir("%s" % (WORKDIR))

denovo_mpi(sys.argv[1])

