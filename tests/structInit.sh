#!/bin/bash

dmd structInit.d
if [ ! -e structInit ]; then
	echo "Compiling structInit.d failed"
fi

rs=`./structInit`
#echo $rs
if [ "$rs" != "3 4 3 4 5" ]
then
	echo "structInit.d failed"
	echo $rs
fi
