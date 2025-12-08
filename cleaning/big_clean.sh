#!/bin/bash
directoryused=$1
name=$(basename "$directoryused" .tgz)
here=$(pwd)
scratch=$(mktemp -d)
tar -xzf "$directoryused" -C "$scratch"
grep -rl "DELETE ME!" "$scratch/$name" | xargs rm -f
cd "$scratch" || exit
tar -czf "$here/cleaned_$(basename "$directoryused")" "$name"
cd "$here" || exit
rm -rf "$scratch"