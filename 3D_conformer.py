#!/usr/bin/env python3

import sys
from rdkit import Chem
from rdkit.Chem import AllChem
from tqdm import tqdm

if len(sys.argv) < 3:
    print("Usage:", sys.argv[0], "<input_file> <output_file>")
    exit()

# Read molecules
suppl = Chem.SDMolSupplier(sys.argv[1])
mols = [m for m in suppl]

print("There are", len(mols), "molecules.")
print("Generating 3D coordinates:")

mols3D = []

for mol in tqdm(mols):
    # Add hydrogens
    mol = Chem.AddHs(mol)
    # Generate 3D coordinates
    AllChem.EmbedMolecule(mol)
    mols3D.append(mol)

# Write output files
w = Chem.SDWriter(sys.argv[2])
for m in mols3D:
    w.write(m)
