module lex.lexer;

import std.stdio;
import std.conv;
import std.string;

import compilerinfo;
import lex.source;
import lex.token;
import pars.parser;
import util.stringbuffer;
import util.stacktrace;

private enum Error {
	CHAR_AFTER_BEGIN_NUMBER,
	UNKNOWN_INPUT_CHARACTER
}

private string errorToString(Error error) {
	debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
		"errorToString");
		
	final switch(error) {
		case Error.CHAR_AFTER_BEGIN_NUMBER:
			return "CHAR_AFTER_BEGIN_NUMBER";
		case Error.UNKNOWN_INPUT_CHARACTER:
			return "UNKNOWN_INPUT_CHARACTER";
	}
}

public class Lexer {
	private Source sourceFile;
	private Parser parser;

	this(Source sourceFile, Parser parser) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__, 
			"Lexer.this");
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
		while(this.sourceFile.hasNextChar()) {
			char it = this.sourceFile.getNextChar();
			//get the next char and put it into the StringBuffer.
			//should a puction,operator or parenthess char follow check if
			//stringbuffer contents equals an keyword. 
			if(sb.getSize() == 0 && ( it == ' ' || it == '\t') ) {
				debug(1025) writeln(__FILE__, ":", __LINE__, "continue");
				continue;
			}
			switch(it) {
				//character
				case 'A': .. case 'Z': case 'a': .. case 'z':
					if(sb.firstIsNumber()) {
						this.raiseLexError(this.sourceFile.getCurrentIdx(), it, curLine,
						this.sourceFile, Error.CHAR_AFTER_BEGIN_NUMBER);
					} else if(sb.holdsOperator()) {
				
					} else {
						sb.pushBack(it);
					}
					break;
				//number
				case '0': .. case '9':
					sb.pushBackNum(it);
					break;
				//the underscore can be used in identifer as well as number
				case '_':
					sb.pushBack(it);
					break;
				//puction
				case '[', ']', '(', ')', '{', '}', ',', ';', ':', '?',
					 '$':
					//push first token
					this.emitToken(sb);

					//push splitter
					this.parser.syncPush(Lexer.puncToToken(it));
					sb.clear();	
					break;
				//operater
				case '/':
					if(sb.getSize() > 0 && sb.getLastChar() == '/') {
						sb.removeLast();
						this.emitToken(sb);	
						this.sourceFile.skipLine();
						sb.clear();	
					} else {
						sb.pushBackOp(it);	
					}
					break;
				case '*':
					//you find yourself a comment
					if(sb.getSize() > 0 && sb.getLastChar() == '/') {
						sb.removeLast();
						this.emitToken(sb);	
						sb.clear();
						char tmp;	
						while(this.sourceFile.hasNextChar()) {
							tmp = this.sourceFile.getNextChar();
							if(tmp == '/' && sb.getSize() > 0 
								&& sb.getLastChar() == '*') {
								sb.clear();
								break;
							}
							sb.pushBack(tmp);
						}
						break;
					} else {
						sb.pushBackOp(it);
						break;
					}
				case '+':
					//you find yourself a nested comment
					if(sb.getSize() > 0 && sb.getLastChar() == '/') {
						sb.removeLast();
						this.emitToken(sb);	
						sb.clear();
						char tmp;	
						while(this.sourceFile.hasNextChar()) {
							tmp = this.sourceFile.getNextChar();
							if(tmp == '/' && sb.getSize() > 0 
								&& sb.getLastChar() == '+') {
								sb.clear();
								break;
							}
							sb.pushBack(tmp);
						}
						break;
					} else {
						sb.pushBackOp(it);
						break;
					}
				case '^', '%', '&', '=', '~', '!',
					'-', '<', '>':
					if(!sb.holdsOperator()) {
						this.emitToken(sb);
						sb.clear();
					}
					sb.pushBackOp(it);
					break;
				case ' ', '\t':
					debug(1025) writeln(__FILE__,":",__LINE__, "blank or tab
						 emit token");
					this.emitToken(sb);
					sb.clear();	
					break;
				default:
					this.raiseLexError(this.sourceFile.getCurrentIdx(), it, curLine,
						this.sourceFile, Error.UNKNOWN_INPUT_CHARACTER);
			}
		}	
	}

	private void emitToken(in StringBuffer!(char) sb) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"emitToken");
		debug st.putArgs("string", "sb", sb.getString());
			
		string sbCntnt = sb.getString();
		debug(1025) writeln(__FILE__,":", __LINE__, " sb = ", sbCntnt);
		if(sb.getSize() == 0) {
			return;
		}
		// keyword
		if(!sb.holdsNumberChar() && !sb.holdsOperator()) {
			TokenType lexed;
			if(sbCntnt in keywordToTokenType) {
				lexed = keywordToTokenType[sbCntnt];
				switch(lexed) {
					case TokenType.File:
						this.parser.syncPush(new Token(lexed,
							to!(dstring)(this.sourceFile.getFileName())));
						break;
					case TokenType.Line:
						/* the plus one is needed because currentLineNumber
						 * returns the index within the line array stored in
						 * file. this array starts with 0. */
						this.parser.syncPush(new Token(lexed,
							to!(dstring)
								(this.sourceFile.currentLineNumber()+1)));
						break;
					default:
						this.parser.syncPush(new Token(lexed));
						break;
				}
			} else {
				switch(sbCntnt) {
					case "__DATA__":
						this.parser.syncPush(new Token(TokenType.Identifier,
							to!(dstring)(sbCntnt)));
						break;
					case "__TIME__":
						this.parser.syncPush(new Token(TokenType.Identifier,
							to!(dstring)(sbCntnt)));
						break;
					case "__TIMESTAMP__":
						this.parser.syncPush(new Token(TokenType.Identifier,
							to!(dstring)(sbCntnt)));
						break;
					case "__VENDOR__":
						this.parser.syncPush(new Token(TokenType.Identifier,
							"dc"d));
						break;
					case "__VERSION__":
						this.parser.syncPush(new Token(TokenType.Identifier,
							compilerinfo.GitHash ~ 
							to!(dstring)(compilerinfo.CompilerID)));
						break;
					default:	
						this.parser.syncPush(new Token(TokenType.Identifier,
							to!(dstring)(sbCntnt)));
						break;
				}
			}
		// operator keyword
		} else if(sb.holdsOperator()) {
			TokenType lexed;
			if(sbCntnt in operatorToTokenType) {
				lexed = operatorToTokenType[sbCntnt];
				this.parser.syncPush(new Token(lexed));
			} else {
				this.raiseUnknownToken(sbCntnt);
			}
		} else {
			// identifer
			this.parser.syncPush(new Token(TokenType.Identifier, 
				to!(dstring)(sbCntnt)));
		}
	}

	private static Token puncToToken(char punc) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"puncToToken");
		debug st.putArgs("char", "punc", punc);
			
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
			case ',':
				return new Token(TokenType.Comma);
			case ';':
				return new Token(TokenType.Semicolon);
			case ':':
				return new Token(TokenType.Colon);
			case '?':
				return new Token(TokenType.QuestionMark);
			case '$':
				return new Token(TokenType.Dollar);
			default:
				st.printTrace();
				assert(0, "Invalid case : " ~ punc);	
		}
	}

	private void raiseUnknownToken(in string uToken) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"raiseUnknownToken");
		debug st.putArgs("string", "uToken", uToken);
			
		writefln("The sequenze %s doesn't not give valid Operator nor
			Identifer");
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
			case Error.UNKNOWN_INPUT_CHARACTER:
				writefln("lex error at: %20s%d position %d: the input character
					is not known",source.getFileName(),
					source.currentLineNumber(), idx);
				return;
		}
	}
}
