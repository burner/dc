#!/bin/bash

dmd hello.d
if [ ! -e hello ]; then
	echo "Compiling hello.d failed"
fi

rs=`./hello`
#echo $rs
if [ "$rs" != "Hello World" ]
then
	echo "Hello.d failed"
fi
