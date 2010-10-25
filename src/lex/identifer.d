module lex.identifer;

import lex.token;

public class Identifer : Token {
	private dstring identifer;

	public static dstring NAME = "Identifer";

	this(Token prev, dstring identifer) {
		super(prev);
		this.identifer = identifer;
	}

	public dstring getIdentifer() {
		return this.identifer;
	}
}
