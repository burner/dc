#!/bin/bash

tests=(`ls *.sh`)
tests=(${tests[q]#"runtest.sh"})
echo ${tests[@]}
for it in "${tests[@]}"
do
	 $"./"$it	
done
