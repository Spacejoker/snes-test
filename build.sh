#!/bin/bash
./wla-65816 -v -o Jens.o Jens.asm 
./wlalink -v -r Jens.link Jens.smc
