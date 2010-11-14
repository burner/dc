module main;

import core.thread;
import std.stdio;

import compilerinfo;
import container.dlst;
import lex.token;
import lex.source;
import lex.lexer;
import pars.parser;
import util.stacktrace;

void main() {
	debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "main");
	//writefln("BuildID = %u", compilerinfo.CompilerID);
	//writefln("Git version = %s", compilerinfo.GitHash);
	
	string[] ts = [ "int main(string[] args) {",
		"\t\tint  foo = 44;",
		"return foo;",
		"}"];
	
	Source tsf = new Source("tst.d", ts);
	Parser p = new Parser();
	Lexer lex = new Lexer(tsf, p);
	lex.lex();
	p.start();
	p.stop();
	p.join();
	//StackTrace.printStats();
}
