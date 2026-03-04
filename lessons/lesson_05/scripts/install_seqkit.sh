#!/bin/bash

# Usage: ./install_seqkit.sh [install location]
# this location MUST be added to your $PATH for it to be accessible from anywhere on your machine

cd $1
wget https://github.com/shenwei356/seqkit/releases/download/v2.10.1/seqkit_linux_amd64.tar.gz
tar -xzf seqkit_linux_amd64.tar.gz
rm seqkit_linux_amd64.tar.gz

