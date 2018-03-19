#!/bin/bash
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the CONTROL_FILE to specify
# each executable per process.
#-------------------------------------------------------
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#

# N: Number of nodes
# n: Number of cores. For stampede it is N*68
# NHOSTS: Usually the same as N
# PPN: Process per node. Since each node has 68 cores and there
#   are 4 threads per core, we want 4*68=272 process in each node

#SBATCH -J convertpdbqt
#SBATCH -N 8 -n 544
#SBATCH -p development
#SBATCH -o Parametric.o%j
#SBATCH -e launch.err%j
#SBATCH -t 02:00:00
#          <------ Account String ----->
# <--- (Use this ONLY if you have MULTIPLE accounts) --->
#SBATCH -A VinaXB
#------------------------------------------------------
module purge
module load TACC
module load launcher
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE=mol2_to_pdbqt.sh
export LAUNCHER_WORKDIR=$PWD
export LAUNCHER_NHOSTS=8
export LAUNCHER_PPN=272
export LAUNCHER_SCHED=interleaved
export LAUNCHER_BIND=1

$LAUNCHER_DIR/paramrun
