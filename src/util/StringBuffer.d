module util.StringBuffer;
import std.stdio;

template StringBuffer(T) {
	class StringBuffer {
		T buffer[];
		uint initSize;
		int bufferPointer;

		public this(in uint initSize) {
			this.initSize = initSize;
			this.bufferPointer = 0;
			this.buffer = new T[this.initSize];
		}

		public void pushBack(in T toAdd) {
			if(this.bufferPointer == initSize) {
				this.buffer.length = initSize * 2u;
				this.initSize *= 2u;
			}
			this.buffer[this.bufferPointer++] = toAdd;
		}
		
		public T popBack() {
			if(this.bufferPointer >= 0) {
				return this.buffer[this.bufferPointer--];
			} else {
				assert(0, "Tryed to popBack empty StringBuffer");
			}
		}

		public bool compare(in string against) {
			if(this.bufferPointer != against.length) return false;
			foreach(uint idx, char it; against) {
				if(it != this.buffer[idx]) return false;
			}
			return true;
		}

		public int getSize() {
			return this.bufferPointer;
		}

		public void clear() {
			this.bufferPointer = 0;
		}
	}
}

unittest {
	StringBuffer!(char) sb = new StringBuffer!(char)(6);
	foreach(it; "Hello World") {
		sb.pushBack(it);
	}
	assert(sb.compare("Hello WorlD"));
	sb.clear();
	foreach(it; "Hello") {
		sb.pushBack(it);
	}
	assert(!sb.compare("Hello"));
	foreach(it; " World Hello World Hello World") {
		sb.pushBack(it);
	}
	assert(sb.compare("Hello World Hello World Hello World"));
}
