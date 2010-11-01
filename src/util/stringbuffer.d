module util.stringbuffer;
import std.stdio;
/** 
 *  Authors: Robert "BuRnEr" Schadek, rburners.gmail.com
 *  Data: 25.10.2010
 *  Examples: See unittest
 *
 *  This template class is used to concat any type of chars into a String.
 *  This is needed in the Lexer. The idea is to push chars into it and than
 *  check if it has a numeric (think holdsNumberChar()) and if not check
 *  against a given keyword with StringBuffer.compare("your keyword").
 */
public template StringBuffer(T) {
	class StringBuffer {
		private T buffer[];
		private uint initSize;
		private int bufferPointer;
		private bool holdsNumber;
		private bool firstCharIsNumber;

		public this(in uint initSize) {
			this.initSize = initSize;
			this.bufferPointer = 0;
			this.holdsNumber = false;
			this.firstCharIsNumber = false;
			this.buffer = new T[this.initSize];
		}

		public void clear() {
			this.bufferPointer = 0;
			this.holdsNumber = false;
		}

		public bool compare(in string against) {
			if(this.bufferPointer != against.length) return false;
			foreach(uint idx, char it; against) {
				if(it != this.buffer[idx]) return false;
			}
			return true;
		}

		public bool holdsNumberChar() {
			return this.holdsNumber;
		}

		public bool firstIsNumber() {
			return this.firstCharIsNumber;
		}

		public void pushBack(in T toAdd) {
			if(this.bufferPointer == initSize) {
				this.buffer.length = initSize * 2u;
				this.initSize *= 2u;
			}
			this.buffer[this.bufferPointer++] = toAdd;
		}

		public void pushBackNum(in T toAdd) {
			this.holdsNumber = true;
			if(this.bufferPointer == 0)
				this.firstCharIsNumber = true;
			if(this.bufferPointer == this.initSize) {
				this.buffer.length = this.initSize * 2u;
				this.initSize *= 2u;
			}
			this.buffer[this.bufferPointer++] = toAdd;
		}
		
		public T popBack() 
			in {}
			out {this.bufferPointer--;}
			body {
			if(this.bufferPointer > 0) {
				return this.buffer[this.bufferPointer-1];
			} else {
				assert(0, "Tryed to popBack empty StringBuffer");
			}
			}

		public int getSize() {
			return this.bufferPointer;
		}

		public immutable(T)[] getString() {
			return this.buffer[0 .. this.bufferPointer].idup;
		}
	}
}

unittest {
	StringBuffer!(char) sb = new StringBuffer!(char)(6);
	foreach(it; "Hello World") {
		sb.pushBack(it);
	}
	assert(!sb.compare("Hello WorlD"));
	sb.clear();
	//sb.popBack();
	foreach(it; "Hello") {
		sb.pushBack(it);
	}
	assert(sb.compare("Hello"));
	foreach(it; " World Hello World Hello World") {
		sb.pushBack(it);
	}
	assert(sb.compare("Hello World Hello World Hello World"));
}
