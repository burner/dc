module lex.lexer;

import std.stdio;
import std.conv;

import lex.source;
import lex.token;
import pars.parser;
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
	private Parser parser;

	this(Source sourceFile, Parser parser) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "Lexer.this");
		st.putArgs("string", "sourceFile", sourceFile.toString());

		this.sourceFile = sourceFile;
		this.parser = parser;
	}

	public void lex() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, "lex");

		StringBuffer!(char) sb = new StringBuffer!(char)(16);
		string curLine;
		//pop = punction operator parenthess
		bool pop = false;
		while(this.sourceFile.nextLineExists()) {
			curLine = this.sourceFile.getNextLine();
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
					case '[', ']', '(', ')', '{', '}', ',', ';', ':', '!', '?',
						 '$', ' ':
						//push first token
						string sbCntnt = sb.getString();
						if(!sb.holdsNumberChar()) {
							TokenType lexed;
							if(sbCntnt in keywordToTokenType) {
								lexed = keywordToTokenType[sbCntnt];
								this.parser.syncPush(new Token(lexed));
							}
						} else {
							this.parser.syncPush(new Token(TokenType.Identifier, to!(dstring)(sbCntnt)));
						}
						
						//push splitter
						this.parser.syncPush(Lexer.puncToToken(it));
						sb.clear();	
						break;
					//operater
					case '^', '%', '&', '/', '=', '*', '+', '~',
						'-', '<', '>':
						break;
				}
			}	
		}	
	}

	private static Token puncToToken(char punc) {
		switch(punc) {
			case '[':
				return new Token(TokenType.OpenBracket);
			case ']':
				return new Token(TokenType.CloseBracket);
			case '{':
				return new Token(TokenType.OpenBrace);
			case '}':
				return new Token(TokenType.CloseBrace);
			case '(':
				return new Token(TokenType.OpenParen);
			case ')':
				return new Token(TokenType.CloseParen);
			case ';':
				return new Token(TokenType.Semicolon);
			case ':':
				return new Token(TokenType.Colon);
			case '?':
				return new Token(TokenType.QuestionMark);
			case '$':
				return new Token(TokenType.Dollar);
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
