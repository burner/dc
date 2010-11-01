module util.stacktrace;

import std.stdio;
import std.date;
import std.conv;
import std.stdarg;
import container.dlst;

public interface Printable {
	public string toString();
}

public final class StackTrace {
	private string file;
	private uint line;
	private string funcName;
	private ulong startTime;
	private string args;
	private uint localDepth;

	private class Stats {
		string funcName;
		uint calls;
		ulong time;
	}

	private static Stats[string] allCalls;
	private static uint depth;
	private static DLinkedList!(StackTrace) stack;

	public static void printStats() {
		writeln("\nStats of all traced function:");
		foreach(idx; allCalls.keys) {
			Stats s = StackTrace.allCalls[idx];
			writefln("function: %35s\tcalled: %6d\ttotaltime: %10d", s.funcName~"():"~idx, s.calls, s.time);
		}
	}

	public static void printTrace() {

	}

	static this() {
		StackTrace.stack = new DLinkedList!(StackTrace)();
	}

	this(string file, uint line, string funcName) {
		this.file = file;
		this.line = line;
		this.funcName = funcName;
		this.startTime = getUTCtime();
		this.localDepth = StackTrace.depth++;
	}

	public void print() {
		for(uint i = 0; i < this.localDepth; i++) {
			write("\t");
		}
		writefln("%s:%d %s(%s)", this.file, this.line, this.funcName, this.args);
	}

	public void putArgs(...) {
		string tmp = "";
		int cnt = 0;
		for(int i = 0; i < _arguments.length; i++) {
			//writeln("typeid = ",_arguments[i]);
			if(_arguments[i] == typeid(string)) {
				tmp ~= va_arg!(string)(_argptr);
				tmp ~= " ";
			} else if(_arguments[i] == typeid(Printable)) {
				tmp ~= va_arg!(Printable)(_argptr).toString();
				tmp ~= " ";
			} else if(_arguments[i] == typeid(int)) {
				tmp ~= to!(string)(va_arg!(int)(_argptr));
				tmp ~= " ";
			} else if(_arguments[i] == typeid(double)) {
				tmp ~= to!(string)(va_arg!(double)(_argptr));
				tmp ~= " ";
			} else {
				writefln("%s:%d Unkown type %s", __FILE__, __LINE__, typeid(_arguments[i]));
			}
		}
		//writeln(tmp);
		this.args = tmp[0 .. $-1];
	}

	~this() {
		ulong timeDiff = getUTCtime() - this.startTime;
		//writeln("destructor ", timeDiff);
		string id = this.file ~ ":" ~ to!string(this.line);
		if(id in StackTrace.allCalls) {
			Stats s = StackTrace.allCalls[id];
			s.calls++;
			s.time += timeDiff;	
		} else {
			Stats s = new Stats;
			StackTrace.allCalls[id] = s;
			s.calls++;
			s.time = timeDiff;	
			s.funcName = this.funcName;
		}
		StackTrace.depth--;
	}
}
