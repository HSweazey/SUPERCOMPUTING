#!/bin/bash

# pipeline script. Calls modular scripts in order
# usage: ./pipeline.sh [N bases to chop]

#set data directory
DATA_DIR="/sciclone/scr10/gzdata440/lesson_05/data/"
# chop up data files
./scripts/chop_files.sh $1

# run stats
./scripts/get_stats.sh


