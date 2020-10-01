import sys
import chimera
#from chimera import runCommand, openModels
from WriteMol2 import writeMol2
from DockPrep import prep

def main():
  print sys.argv

  input_pdb     = sys.argv[1]
  output_prefix = sys.argv[2]

  model = openModels.open(input_pdb)
  #charge the rec with default AMBER ff14SB
  runCommand("addcharge") 
  
  writeMol2(model, output_prefix+"_charged.mol2")

main()

