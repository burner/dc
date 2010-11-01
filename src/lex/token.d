module lex.token;

public abstract class Token {
	private Token prevToken;
	private Token nextToken;

	public static dstring NAME;

	public this(Token prev) {
		this.prevToken = prev;
		this.prevToken.setNextToken(this);
	}

	public void setNextToken(Token next) {
		this.nextToken = next;
	}

	public void setPrevToken(Token next) {
		this.prevToken = next;
	}

	public Token getNextToken() {
		return this.nextToken;
	}

	public Token getPrevToken() {
		return this.prevToken;
	}
};
