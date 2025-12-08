#!/bin/bash
directoryused=$1
name=$(basename "$directoryused" tgz)
here=$(pwd)
scratch=$(mktemp -d)
tar -xzf "$Directoryused" -c "$scratch"
grep -rl "DELETE ME!" "$scratch/$name" | xargs rm -f
cd "$scratch" || exit
tar -czf "$here/cleaned_$directoryused" "$name"