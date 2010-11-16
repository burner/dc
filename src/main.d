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

int main(string[] args) {
	debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "main");
	//writefln("BuildID = %u", compilerinfo.CompilerID);
	//writefln("Git version = %s", compilerinfo.GitHash);
	
	string[] ts = [ "int main(string[] args) {",
		"// asfdasf",
		"/* hello world commend */",
		"/* multiline commend ",
		"more commend */",
		"/+ multiline commend ",
		"more commend +/",
		"\t\tint  foo = 44;",
		" printer!(int)(foo);",
		" printer! (int ) foo;",
		"return foo;",
		"}",
		"",
		"void printer(T)(T t) {",
		"	writeln(t);",
		"}"];
	
	Source tsf = new Source("tst.d", ts);
	Parser p = new Parser();
	Lexer lex = new Lexer(tsf, p);
	lex.lex();
	p.start();
	p.stop();
	p.join();
	StackTrace.printStats();
	return 0;
}
