#!/bin/bash
./../wla-65816 -v -o Main.o Main.asm 
./../wlalink -v -r Main.link Main.smc
