module lex.lexer;

import lex.source;
import util.stringbuffer;

private enum Error {
	CHAR_AFTER_BEGIN_NUMBER,
}

public class Lexer {
	private Source sourceFile;

	this(Source sourceFile) {
		this.sourceFile = sourceFile;
	}

	public void lex() {
		StringBuffer!(char) sb = new StringBuffer!(char)(16);
		string curLine;
		//pop = punction operator parenthess
		bool pop = false;
		while(this.sourceFile.nextLineExists()) {
			curLine = this.sourceFile.getNextLine();
			foreach(uint idx, char it; curLine) {
				pop = false;
				//get the next char and put it into the StringBuffer.
				//should a puction,operator or parenthess char follow check if
				//stringbuffer contents equals an keyword. 
				switch(it) {
					//character
					case 'A': .. case 'Z': case 'a': .. case 'z':
						if(sb.firstIsNumber())
							this.raiseLexError(idx, it, curLine, this.source,
							CHAR_AFTER_BEGIN_NUMBER);
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
					case "_":
						sb.pushBack(it);
						break;
					//puction
					case ' ', '\t', ',', ';', '.', ':':
						pop = true;
						break;
					//operater
					case '^', '!', '$', '%', '&' '/', '=', '?', '*', '+', '~':
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
					switch(sb.getString()) {
						case "abstract":
						case "alias":
						case "align":
						case "asm":
						case "assert":
						case "auto":
						case "body":
						case "break":
						case "case":
						case "cast":
						case "catch":
						case "class":
						case "const":
						case "continue":
						case "debug":
						case "default":
						case "delegate":
						case "delete":
						case "deprecated":
						case "do":
						case "else":
						case "enum":
						case "export":
						case "extern":
						case "false":
						case "final":
						case "finally":
						case "for":
						case "foreach":
						case "foreach_reverse":
						case "function":
						case "goto":
						case "__gshared":
						case "if":
						case "immutable":
						case "import":
						case "in":
						case "inout":
						case "interface":
						case "invariant":
						case "is":
						case "lazy":
						case "macro":
						case "mixin":
						case "module":
						case "new":
						case "nothrow":
						case "null":
						case "out":
						case "__overloadset":
						case "override":
						case "package":
						case "pragma":
						case "private":
						case "protected":
						case "public":
						case "pure":
						case "ref":
						case "return":
						case "shared":
						case "scope":
						case "static":
						case "struct":
						case "super":
						case "switch":
						case "synchronized":
						case "template":
						case "this":
						case "__thread":
						case "throw":
						case "__traits":
						case "true":
						case "try":
						case "typedef":
						case "typeid":
						case "typeof":
						case "union":
						case "unittest":
						case "version":
						case "volatile":
						case "while":
						case "with":
						case "char":
						case "wchar":
						case "dchar":
						case "bool":
						case "byte":
						case "ubyte":
						case "short":
						case "ushort":
						case "int":
						case "uint":
						case "long":
						case "ulong":
						case "cent":
						case "ucent":
						case "float":
						case "double":
						case "real":
						case "ifloat":
						case "idouble":
						case "ireal":
						case "cfloat":
						case "cdouble":
						case "creal":
						case "void":
						case "HEAD":
						case "EOF":
					}
				}
			}	
		}	
	}

	private pure void raiseLexError(uint idx, char it, string curLine,
			Source source, Error errCode) {
		final switch(errCode) {
			case CHAR_AFTER_BEGIN_NUMBER:
				writefln("lex error at: %20s%d position %d: can't place char in 
					identifer which started with a number", 
					source.getFileName(), source.getCurrentLine(), idx);
				return;
		}
	}

	}
}
