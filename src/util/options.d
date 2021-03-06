module util.options;

import std.stdio;

import util.stacktrace;

public final class Options {
	this(string[] args) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"this");
			

	}

	private void parse(string arg) {
		switch(arg) {
			case "-c", "--compile": //only compile
				break;
			case "-cov", "--coverage": //code coverage
				break;
			case "-D", "--Documentation": //run ddoc parser
				break;
			case "-Dddocdir": //output directory of ddoc
				break;
/*
   -Dffilename    write documentation file to filename
  -d             allow deprecated features
  -debug         compile in debug code
  -debug=level   compile in debug code <= level
  -debug=ident   compile in debug code identified by ident
  -debuglib=name    set symbolic debug library to name
  -defaultlib=name  set default library to name
  -deps=filename write module dependencies to filename
  -fPIC          generate position independent code
  -g             add symbolic debug info
  -gc            add symbolic debug info, pretend to be C
  -H             generate 'header' file
  -Hddirectory   write 'header' file to directory
  -Hffilename    write 'header' file to filename
  --help         print help
  -Ipath         where to look for imports
  -ignore        ignore unsupported pragmas
  -inline        do function inlining
  -Jpath         where to look for string imports
  -Llinkerflag   pass linkerflag to link
  -lib           generate library rather than object files
  -man           open web browser on manual page
  -map           generate linker .map file
  -noboundscheck turns off array bounds checking for all functions
  -nofloat       do not emit reference to floating point
  -O             optimize
  -o-            do not write object file
  -odobjdir      write object & library files to directory objdir
  -offilename    name output file to filename
  -op            do not strip paths from source file
  -profile       profile runtime performance of generated code
  -quiet         suppress unnecessary messages
  -release       compile release version
  -run srcfile args...   run resulting program, passing args
  -unittest      compile in unit tests
  -v             verbose
  -version=level compile in version code >= level
  -version=ident compile in version code identified by ident
  -vtls          list all variables going into thread local storage
  -w             enable warnings
  -wi            enable informational warnings
  -X             generate JSON file
  -Xffilename    write JSON file to filename
	*/
			default:
				writefln("the argument %s is not known it will be ignored",
					arg);
				break;	
		}
	}
}
