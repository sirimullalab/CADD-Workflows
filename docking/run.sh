#!/bin/bash

if [ $# -eq 0 ]; then
    echo "USAGE: bash run <target_name>"
    exit 1
fi

TARGET=$1
LINK=http://dude.docking.org/targets/"$TARGET/$TARGET".tar.gz
echo "Downloading "$LINK""
# Download the file
wget $LINK

#Decompress
echo "Decompressing "$1""
tar -xvf "$TARGET".tar.gz

# Get into the directory
cd $TARGET

#Decompress actives and decoys
gunzip actives_final.mol2.gz
gunzip decoys_final.mol2.gz

mkdir actives_mol2
cd actives_mol2
echo "Splitting actives"
python ../../split_mol2.py ../actives_final.mol2
echo "Done"
cd ../
mkdir decoys_mol2
cd decoys_mol2
echo "Splitting decoys"
python ../../split_mol2.py ../decoys_final.mol2
echo "Done"
cd ../

#Convert mol2 files to pdbqt files
echo "Converting mol2 files to pdbqt files"
bash ../convert_ligands2pdbqt.sh
cp ../mol2_to_pdbqt.slurm .

echo "Submitting jobs"
sbatch mol2_to_pdbqt.slurm
rm mol2_to_pdbqt.slurm
echo "Done"

########## SECOND PART (run2.sh)  #####################

echo "mkdir actives
mv actives_final* actives
mkdir decoys
mv decoys_final* decoys

echo \"Generating the docking script\"
bash ../docking_script_generator.sh

echo \"Submitting the job for docking\"
cp ../docking_launcher.slurm .
sbatch docking_launcher.slurm

echo \"DONE\" " > run2.sh

mv run2.sh $TARGET

echo "After the conversion of all the pdbqt files, go to the "$TARGET" directory and do -> bash run2.sh"

