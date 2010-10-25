#!/bin/sh

if ! test -f compilerinfo.d; then 
	echo -e "module compilerinfo;\n\npublic static immutable(uint) CompilerID = 0;" > compilerinfo.d; 
else
	TMP=`grep "= *" compilerinfo.d | cut -b 44- | sed 's/\(.*\)./\1/'	` 
	TMP=$(($TMP +1))
	echo -e "module compilerinfo;\n\npublic static immutable(uint) CompilerID = $TMP;" > compilerinfo.d; 
fi
