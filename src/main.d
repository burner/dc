module main;

import core.thread;
import std.stdio;

import compilerinfo;
import pars.parser;
import util.stacktrace;

void main() {
	debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "main");
	writefln("BuildID = %u", compilerinfo.CompilerID);
	writefln("Git version = %s", compilerinfo.GitHash);

	Parser p = new Parser();
	p.start();
	p.increCount();
	Thread.sleep(100);
	p.stop();
}
