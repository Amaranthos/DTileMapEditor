#!/bin/bash

if [ -e build/run.exe ]; then
	echo "Removing old .exe"
	/bin/rm -f build/run.exe
fi

set LIB=./lib
dmd $(find . -name "*.d") -I../../Libraries/DerelictUtil/source/ -I../../Libraries/DerelictSDL2/source/ -ofbuild/run

if [ -e build/run.obj ]; then
	echo "Removing .obj"
	/bin/rm -f build/run.obj
fi

if [ -e build/run.exe ]; then
	echo "Running new .exe"
	build/run.exe
fi