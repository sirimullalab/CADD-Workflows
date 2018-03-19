#!/bin/bash

for f in ./actives_mol2/*.mol2
do
#/home/ssirimulla/mgltools_x86_64Linux2_1.5.6/bin/pythonsh ./prepare_ligand4.py -l "$f"
echo "/work/04268/tg835677/stampede2/mgltools_x86_64Linux2_1.5.6/bin/pythonsh ../prepare_ligand4.py -l $f"
done > mol2_to_pdbqt.sh

for f in ./decoys_mol2/*.mol2
do
#/home/ssirimulla/mgltools_x86_64Linux2_1.5.6/bin/pythonsh ./prepare_ligand4.py -l "$f"
echo "/work/04268/tg835677/stampede2/mgltools_x86_64Linux2_1.5.6/bin/pythonsh ../prepare_ligand4.py -l $f"
done >> mol2_to_pdbqt.sh

exit 0
