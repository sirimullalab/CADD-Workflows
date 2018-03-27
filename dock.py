# Script for docking DUD-E compounds in parallel

# Usage: python dock.py <dude_receptor_dir> num_processes
# e.g. dock.py DUD-E/all/ampc/ 64

import glob
from multiprocessing import Pool
from os import path
from subprocess import call
import sys
import time

SMINA_PATH="./smina"


def dock(ligand):
    """Function that calls smina to dock a ligand."""
    ligname = path.splitext(ligand)[0]
    # Call vina process
    print("Running on ligand:", ligand)
    call([SMINA_PATH, "-r", receptor, "-l", ligand, "--autobox_ligand", crystal_ligand,
          "--num_modes", str(num_modes), "-o", ligname + "_out.pdbqt", "--cpu", "1"])


if __name__ == "__main__":
    # User inputs
    target_path = sys.argv[1]
    n_cpus = int(sys.argv[2])
    # Docking parameters
    receptor = target_path + "receptor.pdbqt"
    crystal_ligand = target_path + "crystal_ligand.mol2"
    actives = glob.glob(target_path + "actives/*.pdbqt")
    decoys = glob.glob(target_path + "decoys/*.pdbqt")
    ligands = decoys #actives + decoys
    num_modes = 12
    # Start process pool
    pool = Pool(processes=n_cpus)
    start_time = time.time()
    # Run the dock function for each ligand
    pool.map(dock, ligands)
    stop_time = time.time()
    print("Job completed in:", stop_time - start_time, "seconds")
