#!/bin/bash

for f in decoys/*.pdbqt
do
echo "../smina -r receptor.pdb -l "$f" --autobox_ligand crystal_ligand.mol2 -o "${f%.pdbqt}".out.pdbqt --num_modes 20"
done  > docking.sh
for f in actives/*.pdbqt
do
echo "../smina -r receptor.pdb -l "$f" --autobox_ligand crystal_ligand.mol2 -o "${f%.pdbqt}".out.pbdqt --num_modes 20"
#echo "$f"
done  >> docking.sh
