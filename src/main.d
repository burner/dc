module main;

import core.thread;
import std.stdio;

import compilerinfo;
import container.dlst;
import lex.token;
import pars.parser;
import util.stacktrace;

void main() {
	debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "main");
	writefln("BuildID = %u", compilerinfo.CompilerID);
	writefln("Git version = %s", compilerinfo.GitHash);

	Parser p = new Parser();
	p.start();

	auto ll = new DLinkedList!(Token)();
	ll.pushBack(new Token(TokenType.Abstract));
	p.syncPush(ll);

	Thread.sleep(100);
	p.stop();
}
