#!/bin/bash

for line in $(cat mktoc)
do
	fn=`echo ${line} | tr A-Z a-z`
	f=$fn".d"
	echo -e "module lex.$fn;\n\nimport lex.token;\n\nclass $line : Token {\n\tpublic static final dstring NAME = \"$line\";\n\n\tthis(Token prev) {\n\t\tsuper(prev);\n\t}\n}" > $f
	rm $f
done
