#!/bin/bash
set LIB=./lib
dmd src/*.d -I../../Libraries/DerelictUtil/source/ -I../../Libraries/DerelictSDL2/source/ -ofrun
rm -f run.obj
./run.exe
exit $?