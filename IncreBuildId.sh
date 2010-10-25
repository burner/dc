#!/bin/sh

if ! test -f CompilerInfo.d; then 
	echo -e "module CompilerInfo;\n\npublic static immutable(uint) CompilerID = 0;" > CompilerInfo.d; 
else
	TMP=`grep "= *" CompilerInfo.d | cut -b 44- | sed 's/\(.*\)./\1/'	` 
	TMP=$(($TMP +1))
	echo -e "module CompilerInfo;\n\npublic static immutable(uint) CompilerID = $TMP;" > CompilerInfo.d; 
fi
