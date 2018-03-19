################################################
#  Script for splitting multiligand mol2 files #
################################################

import sys
import gzip

def split_file(mol2_file):
    mol = ""
    #with open(mol2_file, 'rt') as f:
    f = open(mol2_file, 'rt')
    for line in f:
        if line.startswith("@<TRIPOS>MOLECULE"):
            if mol != "":
                yield mol
            mol = ""
            mol += line
        else:
            mol += line

file_name = sys.argv[1]
root_name = file_name.split(".")[-2][1:]

for count, contents in enumerate(split_file(file_name)):
    outfile = open(root_name + "_" + str(count).zfill(5) + ".mol2", 'w')
    #with open(root_name + "_" + str(count).zfill(5) + ".mol2", 'w') as outfile:
    outfile.write(contents)
