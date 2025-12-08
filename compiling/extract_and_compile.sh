#!/bin/bash
# $1 is n such that it will run NthPrime with n
tar -xzf NthPrime.tgz
cd NthPrime || exit 
gcc -o NthPrime main.c nth_prime.c
./NthPrime "$1"