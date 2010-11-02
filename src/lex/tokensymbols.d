module lex.tokensymbols;

import lex.token;

public class Abstract : Token {
	public static dstring NAME = "abstract";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Alias : Token {
	public static dstring NAME = "alias";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Align : Token {
	public static dstring NAME = "align";
	
	public this(Token prev) {
		super(prev);
	}
}

public class AndAssign : Token {
	public static dstring NAME = "&=";
	
	public this(Token prev) {
		super(prev);
	}
}

public class AndBinary : Token {
	public static dstring NAME = "&";
	
	public this(Token prev) {
		super(prev);
	}
}

public class AndLogical : Token {
	public static dstring NAME = "&&";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Asm : Token {
	public static dstring NAME = "asm";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Assert : Token {
	public static dstring NAME = "assert";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Assign : Token {
	public static dstring NAME = "=";
	
	public this(Token prev) {
		super(prev);
	}
}

public class At : Token {
	public static dstring NAME = "at";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Auto : Token {
	public static dstring NAME = "auto";
	
	public this(Token prev) {
		super(prev);
	}
}

public class BOF : Token {
	public static dstring NAME = "BOF";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Body : Token {
	public static dstring NAME = "body";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Break : Token {
	public static dstring NAME = "break";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Case : Token {
	public static dstring NAME = "case";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Cast : Token {
	public static dstring NAME = "cast";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Catch : Token {
	public static dstring NAME = "catch";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Class : Token {
	public static dstring NAME = "";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Comma : Token {
	public static dstring NAME = ",";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Comment : Token {
	public static dstring NAME = "/* // /+ +/ */";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Const : Token {
	public static dstring NAME = "const";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Continue : Token {
	public static dstring NAME = "continue";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Date : Token {
	public static dstring NAME = "__DATE__";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Debug : Token {
	public static dstring NAME = "debug";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Default : Token {
	public static dstring NAME = "default";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Delegate : Token {
	public static dstring NAME = "delegate";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Delete : Token {
	public static dstring NAME = "delete";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Dot : Token {
	public static dstring NAME = ".";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Deprecated : Token {
	public static dstring NAME = "deprecated";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Div : Token {
	public static dstring NAME = "/";
	
	public this(Token prev) {
		super(prev);
	}
}

public class DivAssign : Token {
	public static dstring NAME = "/=";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Do : Token {
	public static dstring NAME = "do";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Dollar : Token {
	public static dstring NAME = "$";
	
	public this(Token prev) {
		super(prev);
	}
}

public class EOF : Token {
	public static dstring NAME = "EOF";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Else : Token {
	public static dstring NAME = "else";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Enum : Token {
	public static dstring NAME = "enum";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Equal : Token {
	public static dstring NAME = "==";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Export : Token {
	public static dstring NAME = "export";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Extern : Token {
	public static dstring NAME = "extern";
	
	public this(Token prev) {
		super(prev);
	}
}

public class File : Token {
	public static dstring NAME = "__FILE__";
	public dstring file;
	
	public this(Token prev, dstring file) {
		super(prev);
		this.file = file;
	}

	public dstring getFile() {
		return this.file;
	}
}

public class False : Token {
	public static dstring NAME = "false";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Final : Token {
	public static dstring NAME = "final";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Finally : Token {
	public static dstring NAME = "finally";
	
	public this(Token prev) {
		super(prev);
	}
}

public class For : Token {
	public static dstring NAME = "for";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Foreach : Token {
	public static dstring NAME = "foreach";
	
	public this(Token prev) {
		super(prev);
	}
}

public class ForeachReverse: Token {
	public static dstring NAME = "foreach_reverse";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Function : Token {
	public static dstring NAME = "function";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Goto : Token {
	public static dstring NAME = "goto";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Greater : Token {
	public static dstring NAME = ">";
	
	public this(Token prev) {
		super(prev);
	}
}

public class GreaterEqual : Token {
	public static dstring NAME = ">=";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Identifer : Token {
	public static dstring NAME = "IDENTIFER";
	private dstring id;
	
	public this(Token prev, dstring id) {
		super(prev);
		this.id = id;
	}

	public dstring getId() {
		return this.id;
	}
} 

public class LBrace : Token {
	public static dstring NAME = "(";
	
	public this(Token prev) {
		super(prev);
	}
}

public class LBracket : Token {
	public static dstring NAME = "{";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Less : Token {
	public static dstring NAME = "<";
	
	public this(Token prev) {
		super(prev);
	}
}

public class LessEqual : Token {
	public static dstring NAME = "<=";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Line : Token {
	public static dstring NAME = "__LINE__";
	public int line;
	
	public this(Token prev, int line) {
		super(prev);
		this.line = line;
	}

	public int getLine() {
		return this.line;
	}
}

public class LParen : Token {
	public static dstring NAME = "[";
	
	public this(Token prev) {
		super(prev);
	}
}

public class RBracket : Token {
	public static dstring NAME = "}";
	
	public this(Token prev) {
		super(prev);
	}
}

public class RBrace : Token {
	public static dstring NAME = ")";
	
	public this(Token prev) {
		super(prev);
	}
}

public class RParen : Token {
	public static dstring NAME = "]";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Slice : Token {
	public static dstring NAME = "..";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Time : Token {
	public static dstring NAME = "__TIME__";
	
	public this(Token prev) {
		super(prev);
	}
}

public class NotEqual : Token {
	public static dstring NAME = "!=";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Not : Token {
	public static dstring NAME = "!";
	
	public this(Token prev) {
		super(prev);
	}
}

public class Vendor : Token {
	public static dstring NAME = "__LINE__";
	public dstring vendor;
	
	public this(Token prev, dstring vendor) {
		super(prev);
		this.vendor = vendor;
	}

	public dstring getVendor() {
		return this.vendor;
	}
}

public class Version : Token {
	public static dstring NAME = "__LINE__";
	public dstring versionId;
	
	public this(Token prev, dstring versionId) {
		super(prev);
		this.versionId = versionId;
	}

	public dstring getVersion() {
		return this.versionId;
	}
}
