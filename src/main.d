import std.stdio;
import compilerinfo;
import util.stacktrace;

void main() {
	scope StackTrace st = new StackTrace(__FILE__, __LINE__, "main");	
	writefln("BuildID = %u", compilerinfo.CompilerID);
}
