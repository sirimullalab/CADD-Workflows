# Script for docking DUD-E compounds in parallel

# Usage: python dock.py <dude_receptor_dir> num_processes
# e.g. dock.py DUD-E/all/ampc/ 64

import glob
from multiprocessing import Pool
from os import path
from subprocess import call
import sys
import time
from tqdm import *

SMINA_PATH="./smina"

def dock(ligand):
    """Function that calls smina to dock a ligand."""
    ligname = path.splitext(path.basename(ligand))[0]
    # Call vina process
    call("{0} -r {1} -l {2} --autobox_ligand {3} --num_modes {4} " +
         "-o {5}_out.pdbqt".format(SMINA_PATH, receptor, ligand,
                                   crystal_ligand, num_modes, ligname) 


if __name__ == "__main__":
    # User inputs
    target_path = sys.argv[1]
    n_cpus = int(sys.argv[2])
    # Docking parameters
    receptor = target_path + "receptor.pdbqt"
    crystal_ligand = target_path + "crystal_ligand.mol2"
    actives = glob.glob(target_path + "actives/*.pdbqt")
    decoys = glob.glob(target_path + "decoys/*.pdbqt")
    ligands = actives + decoys
    num_modes = 12
    # Start process pool
    pool = Pool(processes=n_cpus)
    num_jobs = len(ligands)
    with tqdm(total=num_jobs) as pbar:
    	# Run the dock function for each ligand
    	for i, _ in tqdm(enumerate(pool.imap_unordered(dock, ligands))):
            pbar.update()
