module stacktrace;

import std.stdio;
import std.date;
import std.conv;

public interface Printable {
	public string toString();
}

scope final class StackTrace {
	private string file;
	private uint line;
	private string funcName;
	private ulong startTime;

	private class Stats {
		uint calls;
		ulong time;
	}

	private static Stats[string] allCalls;

	public static void printStats() {
		foreach(idx; allCalls.keys) {
			Stats s = StackTrace.allCalls[idx];
			writefln("%20s called: %6d  totaltime %10d", idx, s.calls, s.time);
		}
	}

	this(string file, uint line, string funcName) {
		this.file = file;
		this.line = line;
		this.funcName = funcName;
		this.startTime = getUTCtime();
	}

	~this() {
		ulong timeDiff = getUTCtime() - this.startTime;
		writeln("destructor ", timeDiff);
		string id = this.file ~ to!string(this.line);
		if(id in StackTrace.allCalls) {
			Stats s = StackTrace.allCalls[id];
			s.calls++;
			s.time += timeDiff;	
		} else {
			Stats s = new Stats;
			StackTrace.allCalls[id] = s;
			s.calls++;
			s.time += timeDiff;	

		}
	}
}

void main() {
	//scope StackTrace st = new StackTrace(__FILE__, __LINE__, "main");
	writeln("before foo");
	foo();
	writeln("after foo");
	StackTrace.printStats();
}

void foo() {
	scope StackTrace st = new StackTrace(__FILE__, __LINE__, "foo");
	int a = 123427;
	ulong cnt = 0;
	for(int j = 0; j < 100; j++) {
		for(int i = 0; i < a; i++) {
			cnt += i/1000;
		}	
	}
	writeln("foobar", cnt);
}
