module lex.lexer;

import std.stdio;

import lex.source;
import lex.token;
import util.stringbuffer;
import util.stacktrace;

private enum Error {
	CHAR_AFTER_BEGIN_NUMBER,
}

private string errorToString(Error error) {
	switch(error) {
		case Error.CHAR_AFTER_BEGIN_NUMBER:
			return "CHAR_AFTER_BEGIN_NUMBER";
	}
}

public class Lexer {
	private Source sourceFile;

	this(Source sourceFile) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "Lexer.this");
		st.putArgs("string", "sourceFile", sourceFile.toString());

		this.sourceFile = sourceFile;
	}

	public void lex() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "lex");

		StringBuffer!(char) sb = new StringBuffer!(char)(16);
		string curLine;
		//pop = punction operator parenthess
		bool pop = false;
		while(this.sourceFile.nextLineExists()) {
			curLine = this.sourceFile.getNextLine();
			Token parsed;
			Token splitter;
			foreach(uint idx, char it; curLine) {
				pop = false;
				if(it == ' ' || it == '\t') {
					continue;
				}
				//get the next char and put it into the StringBuffer.
				//should a puction,operator or parenthess char follow check if
				//stringbuffer contents equals an keyword. 
				switch(it) {
					//character
					case 'A': .. case 'Z': case 'a': .. case 'z':
						if(sb.firstIsNumber()) {
							this.raiseLexError(idx, it, curLine,
							this.sourceFile, Error.CHAR_AFTER_BEGIN_NUMBER);
						} else {
							sb.pushBack(it);
						}
						break;
					//number
					case '0': .. case '9':
						if(sb.getSize() == 0) {
							sb.pushBackNum(it);
						}
						break;
					//the underscore can be used in identifer as well as number
					case '_':
						sb.pushBack(it);
						break;
					//puction
					case ',', ';', '.', ':':
						splitter = Lexer.puncToToken(it);
						pop = true;
						break;
					//operater
					case '^', '!', '$', '%', '&', '/', '=', '?', '*', '+', '~',
						'-', '<', '>':
						pop = true;
						break;
					//parenthess
					case '(', ')', '{', '}', '"':
						pop = true;
						break;
				}

				//see comment before leading switch case statement
				//hildsNumberChar is checked because no keyword consists of
				//numbers
				if(pop && !sb.holdsNumberChar()) {
				}
			}	
		}	
	}

	private static Token puncToToken(char punc) {
		switch(punc) {
			case ',':
				return new Token(TokenType.Comma);
			case ';':
				return new Token(TokenType.Semicolon);
			case '.':
				return new Token(TokenType.Dot);
			case ':':
				return new Token(TokenType.Colon);
			default:
				assert(0, "Invalid case : " ~ punc);	
		}
	}

	private void raiseLexError(uint idx, char it, string curLine,
			Source source, Error errCode) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"raiseLexError");
		debug st.putArgs("uint", "idx", idx, "char", "it", it, "string",
			"curLine", curLine, "string", "source", source.toString(), "string",
			"errCode", errorToString(errCode));
			
		final switch(errCode) {
			case Error.CHAR_AFTER_BEGIN_NUMBER:
				writefln("lex error at: %20s%d position %d: can't place char in 
					identifer which started with a number", 
					source.getFileName(), source.currentLineNumber(), idx);
				return;
		}
	}
}
