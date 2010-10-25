import std.stdio;
import compilerinfo;

void main() {
	writefln("BuildID = %u", compilerinfo.CompilerID);
}
