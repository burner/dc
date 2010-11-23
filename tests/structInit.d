import std.stdio;

struct A {
	int x, y;
}

struct B {
	A a;
	int z;
}

void main() {
	A a = {3,4};
	B b = { {3,4}, 5};
	writefln("%d %d %d %d %d",a.x, a.y, b.a.x, b.a.y, b.z);
}
