module lex.token;

import util.stacktrace;

public static TokenType[string] keywordToTokenType;
public static TokenType[string] operatorToTokenType;

public static immutable string[183] tokenToString = [
"none", "identifier", "string literal", "character literal",
"integer literal", "float literal", "abstract", "alias", "align",
"asm", "assert", "auto", "body", "bool", "break", "byte", "case",
"cast", "catch", "cdouble", "cent", "cfloat", "char", "class",
"const", "continue", "creal", "dchar", "debug", "default",
"delegate", "delete", "deprecated", "do", "double", "else", "enum",
"export", "extern", "false", "final", "finally", "float", "for",
"foreach", "foreach_reverse", "function", "goto", "idouble", "if",
"ifloat", "immutable", "import", "in", "inout", "int", "interface",
"invariant", "ireal", "is", "lazy", "long", "macro", "mixin", "module",
"new", "nothrow", "null", "out", "override", "package", "pragma",
"private", "protected", "public", "pure", "real", "ref", "return",
"scope", "shared", "short", "static", "struct", "string", "super",
"switch", "synchronized", "template", "this", "throw", "true",
"try", "typedef", "typeid", "typeof", "ubyte", "ucent", "uint",
"ulong", "union", "unittest", "ushort", "version", "void", "volatile",
"wchar", "while", "with", "__FILE__", "__LINE__", "__gshared",
"__thread", "__traits", "@property", "@safe", "@trusted", "@system",
"@disable",
"/", "/=", ".", "..", "...", "&", "&=", "&&", "|", "|=", "||",
"-", "-=", "--", "+", "+=", "++", "<", "<=", "<<", "<<=", "<>", "<>=",
">", ">=", ">>=", ">>>=", ">>", ">>>", "!", "!=", "!<>", "!<>=", "!<",
"!<=", "!>", "!>=", "(", ")", "[", "]", "{", "}", "?", ",", ";",
":", "$", "=", "==", "*", "*=", "%", "%=", "^", "^=", "^^", "~", "~=",
"(>^(>O_O)>", "symbol", "number", "BEGIN", "EOF"
];

static this() {
	with (TokenType) {
		keywordToTokenType["abstract"] = Abstract;
		keywordToTokenType["alias"] = Alias;
		keywordToTokenType["align"] = Align;
		keywordToTokenType["asm"] = Asm;
		keywordToTokenType["assert"] = Assert;
		keywordToTokenType["auto"] = Auto;
		keywordToTokenType["body"] = Body;
		keywordToTokenType["bool"] = Bool;
		keywordToTokenType["break"] = Break;
		keywordToTokenType["byte"] = Byte;
		keywordToTokenType["case"] = Case;
		keywordToTokenType["cast"] = Cast;
		keywordToTokenType["catch"] = Catch;
		keywordToTokenType["cdouble"] = Cdouble;
		keywordToTokenType["cent"] = Cent;
		keywordToTokenType["cfloat"] = Cfloat;
		keywordToTokenType["char"] = Char;
		keywordToTokenType["class"] = Class;
		keywordToTokenType["const"] = Const;
		keywordToTokenType["continue"] = Continue;
		keywordToTokenType["creal"] = Creal;
		keywordToTokenType["dchar"] = Dchar;
		keywordToTokenType["debug"] = Debug;
		keywordToTokenType["default"] = Default;
		keywordToTokenType["delegate"] = Delegate;
		keywordToTokenType["delete"] = Delete;
		keywordToTokenType["deprecated"] = Deprecated;
		keywordToTokenType["do"] = Do;
		keywordToTokenType["double"] = Double;
		keywordToTokenType["else"] = Else;
		keywordToTokenType["enum"] = Enum;
		keywordToTokenType["export"] = Export;
		keywordToTokenType["extern"] = Extern;
		keywordToTokenType["false"] = False;
		keywordToTokenType["final"] = Final;
		keywordToTokenType["finally"] = Finally;
		keywordToTokenType["float"] = Float;
		keywordToTokenType["for"] = For;
		keywordToTokenType["foreach"] = Foreach;
		keywordToTokenType["foreach_reverse"] = ForeachReverse;
		keywordToTokenType["function"] = Function;
		keywordToTokenType["goto"] = Goto;
		keywordToTokenType["idouble"] = Idouble;
		keywordToTokenType["if"] = If;
		keywordToTokenType["ifloat"] = Ifloat;
		keywordToTokenType["immutable"] = Immutable;
		keywordToTokenType["import"] = Import;
		keywordToTokenType["in"] = In;
		keywordToTokenType["inout"] = Inout;
		keywordToTokenType["int"] = Int;
		keywordToTokenType["interface"] = Interface;
		keywordToTokenType["invariant"] = Invariant;
		keywordToTokenType["ireal"] = Ireal;
		keywordToTokenType["is"] = Is;
		keywordToTokenType["lazy"] = Lazy;
		keywordToTokenType["long"] = Long;
		keywordToTokenType["macro"] = Macro;
		keywordToTokenType["mixin"] = Mixin;
		keywordToTokenType["module"] = Module;
		keywordToTokenType["new"] = New;
		keywordToTokenType["nothrow"] = Nothrow;
		keywordToTokenType["null"] = Null;
		keywordToTokenType["out"] = Out;
		keywordToTokenType["override"] = Override;
		keywordToTokenType["package"] = Package;
		keywordToTokenType["pragma"] = Pragma;
		keywordToTokenType["private"] = Private;
		keywordToTokenType["protected"] = Protected;
		keywordToTokenType["public"] = Public;
		keywordToTokenType["pure"] = Pure;
		keywordToTokenType["real"] = Real;
		keywordToTokenType["ref"] = Ref;
		keywordToTokenType["return"] = Return;
		keywordToTokenType["scope"] = Scope;
		keywordToTokenType["shared"] = Shared;
		keywordToTokenType["short"] = Short;
		keywordToTokenType["static"] = Static;
		keywordToTokenType["struct"] = Struct;
		keywordToTokenType["string"] = String;
		keywordToTokenType["super"] = Super;
		keywordToTokenType["switch"] = Switch;
		keywordToTokenType["synchronized"] = Synchronized;
		keywordToTokenType["template"] = Template;
		keywordToTokenType["this"] = This;
		keywordToTokenType["throw"] = Throw;
		keywordToTokenType["true"] = True;
		keywordToTokenType["try"] = Try;
		keywordToTokenType["typedef"] = Typedef;
		keywordToTokenType["typeid"] = Typeid;
		keywordToTokenType["typeof"] = Typeof;
		keywordToTokenType["ubyte"] = Ubyte;
		keywordToTokenType["ucent"] = Ucent;
		keywordToTokenType["uint"] = Uint;
		keywordToTokenType["ulong"] = Ulong;
		keywordToTokenType["union"] = Union;
		keywordToTokenType["unittest"] = Unittest;
		keywordToTokenType["ushort"] = Ushort;
		keywordToTokenType["version"] = Version;
		keywordToTokenType["void"] = Void;
		keywordToTokenType["volatile"] = Volatile;
		keywordToTokenType["wchar"] = Wchar;
		keywordToTokenType["while"] = While;
		keywordToTokenType["with"] = With;
		keywordToTokenType["__FILE__"] = File;
		keywordToTokenType["__LINE__"] = Line;
		keywordToTokenType["__gshared"] = __Gshared;
		keywordToTokenType["__thread"] = __Thread;
		keywordToTokenType["__traits"] = __Traits;
		keywordToTokenType["@property"] = atProperty;
		keywordToTokenType["@safe"] = atSafe;
		keywordToTokenType["@trusted"] = atTrusted;
		keywordToTokenType["@system"] = atSystem;
		keywordToTokenType["@disable"] = atDisable;

		operatorToTokenType["/"] = Slash;
		operatorToTokenType["/="] = SlashAssign;
		operatorToTokenType["."] = Dot;
		operatorToTokenType[".."] = DoubleDot;
		operatorToTokenType["..."] = TripleDot;
		operatorToTokenType["&"] = Ampersand;
		operatorToTokenType["&="] = AmpersandAssign;
		operatorToTokenType["&&"] = DoubleAmpersand;
		operatorToTokenType["|"] = Pipe;
		operatorToTokenType["|="] = PipeAssign;
		operatorToTokenType["||"] = DoublePipe;
		operatorToTokenType["-"] = Dash;
		operatorToTokenType["-="] = DashAssign;
		operatorToTokenType["--"] = DoubleDash;
		operatorToTokenType["+"] = Plus;
		operatorToTokenType["+="] = PlusAssign;
		operatorToTokenType["++"] = DoublePlus;
		operatorToTokenType["<"] = Less;
		operatorToTokenType["<="] = LessAssign;
		operatorToTokenType["<<"] = DoubleLess;
		operatorToTokenType["<<="] = DoubleLessAssign;
		operatorToTokenType["<>"] = LessGreater;
		operatorToTokenType["<>="] = LessGreaterAssign;
		operatorToTokenType[">"] = Greater;
		operatorToTokenType[">="] = GreaterAssign;
		operatorToTokenType[">>="] = DoubleGreaterAssign;
		operatorToTokenType[">>>="] = TripleGreaterAssign;
		operatorToTokenType[">>"] = DoubleGreater;
		operatorToTokenType[">>>"] = TripleGreater;
		operatorToTokenType["!"] = Bang;
		operatorToTokenType["!="] = BangAssign;
		operatorToTokenType["!<>"] = BangLessGreater;
		operatorToTokenType["!<>="] = BangLessGreaterAssign;
		operatorToTokenType["!<"] = BangLess;
		operatorToTokenType["!<="] = BangLessAssign;
		operatorToTokenType["!>"] = BangGreater;
		operatorToTokenType["!>="] = BangGreaterAssign;
		operatorToTokenType["="] = Assign;
		operatorToTokenType["=="] = DoubleAssign;
		operatorToTokenType["*"] = Asterix;
		operatorToTokenType["*="] = AsterixAssign;
		operatorToTokenType["%"] = Percent;
		operatorToTokenType["%="] = PercentAssign;
		operatorToTokenType["^"] = Caret;
		operatorToTokenType["^="] = CaretAssign;
		operatorToTokenType["^^"] = DoubleCaret;
		operatorToTokenType["~"] = Tilde;
		operatorToTokenType["~="] = TildeAssign;
	}
	keywordToTokenType.rehash();
	operatorToTokenType.rehash();
}

public enum TokenType {
	None = 0,
	
	// Literals
	Identifier,
	StringLiteral,
	CharacterLiteral,
	IntegerLiteral,
	FloatLiteral,
	
	// Keywords
	Abstract, Alias, Align, Asm, Assert, Auto,
	Body, Bool, Break, Byte,
	Case, Cast, Catch, Cdouble, Cent, Cfloat, Char,
	Class, Const, Continue, Creal,
	Dchar, Debug, Default, Delegate, Delete,
	Deprecated, Do, Double,
	Else, Enum, Export, Extern,
	False, Final, Finally, Float, For, Foreach,
	ForeachReverse, Function,
	Goto,
	Idouble, If, Ifloat, Immutable, Import, In,
	Inout, Int, Interface, Invariant, Ireal, Is,
	Lazy, Long,
	Macro, Mixin, Module,
	New, Nothrow, Null,
	Out, Override,
	Package, Pragma, Private, Protected, Public, Pure,
	Real, Ref, Return,
	Scope, Shared, Short, Static, String, Struct, Super,
	Switch, Synchronized,
	Template, This, Throw, True, Try, Typedef,
	Typeid, Typeof,
	Ubyte, Ucent, Uint, Ulong, Union, Unittest, Ushort,
	Version, Void, Volatile,
	Wchar, While, With,
	File, Line, __Gshared, __Thread, __Traits,
	atProperty, atSafe, atTrusted, atSystem, atDisable,
	
	/// Symbols.
	Slash,			 // /
	SlashAssign,	   // /=
	Dot,			   // .
	DoubleDot,		 // ..
	TripleDot,		 // ...
	Ampersand,		 // &
	AmpersandAssign,   // &=
	DoubleAmpersand,   // &&
	Pipe,			  // |
	PipeAssign,		// |=
	DoublePipe,		// ||
	Dash,			  // -
	DashAssign,		// -=
	DoubleDash,		// --
	Plus,			  // +
	PlusAssign,		// +=
	DoublePlus,		// ++
	Less,			  // <
	LessAssign,		// <=
	DoubleLess,		// <<
	DoubleLessAssign,  // <<=
	LessGreater,	   // <>
	LessGreaterAssign, // <>= 
	Greater,		   // >
	GreaterAssign,	 // >=
	DoubleGreaterAssign, // >>=
	TripleGreaterAssign, // >>>=
	DoubleGreater,	   // >>
	TripleGreater,	   // >>>
	Bang,				// !
	BangAssign,		  // !=
	BangLessGreater,	 // !<>
	BangLessGreaterAssign,  // !<>=
	BangLess,			   // !<
	BangLessAssign,		 // !<=
	BangGreater,			// !>
	BangGreaterAssign,	  // !>=
	OpenParen,			  // (
	CloseParen,			 // )
	OpenBracket,			// [
	CloseBracket,		   // ]
	OpenBrace,			  // {
	CloseBrace,			 // }
	QuestionMark,		   // ?
	Comma,				  // ,
	Semicolon,			  // ;
	Colon,				  // :
	Dollar,				 // $
	Assign,				 // =
	DoubleAssign,		   // ==
	Asterix,				// *
	AsterixAssign,		  // *=
	Percent,				// %
	PercentAssign,		  // %=
	Caret,				  // ^
	CaretAssign,			// ^=
	DoubleCaret,			// ^^
	Tilde,				  // ~
	TildeAssign,			// ~=
	
	opKirbyRape,			// (>^(>O_O)>
	Symbol,
	Number,
	
	Begin,
	End,
}

string tokenTypeToString(TokenType ty) {
	debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
		"tokenTypeToString");
	debug st.putArgs("string", "ty", ty);
		
	final switch(ty) {
		case TokenType.None:
			return "None";
		case TokenType.Identifier:
			return "Identifier";
		case TokenType.StringLiteral:
			return "StringLiteral";
		case TokenType.CharacterLiteral:
			return "CharacterLiteral";
		case TokenType.IntegerLiteral:
			return "IntegerLiteral";
		case TokenType.FloatLiteral:
			return "FloatLiteral";
		case TokenType.Abstract:
			return "Abstract";
		case TokenType.Alias:
			return "Alias";
		case TokenType.Align:
			return "Align";
		case TokenType.Asm:
			return "Asm";
		case TokenType.Assert:
			return "Assert";
		case TokenType.Auto:
			return "Auto";
		case TokenType.Body:
			return "Body";
		case TokenType.Bool:
			return "Bool";
		case TokenType.Break:
			return "Break";
		case TokenType.Byte:
			return "Byte";
		case TokenType.Case:
			return "Case";
		case TokenType.Cast:
			return "Cast";
		case TokenType.Catch:
			return "Catch";
		case TokenType.Cdouble:
			return "Cdouble";
		case TokenType.Cent:
			return "Cent";
		case TokenType.Cfloat:
			return "Cfloat";
		case TokenType.Char:
			return "Char";
		case TokenType.Class:
			return "Class";
		case TokenType.Const:
			return "Const";
		case TokenType.Continue:
			return "Continue";
		case TokenType.Creal:
			return "Creal";
		case TokenType.Dchar:
			return "Dchar";
		case TokenType.Debug:
			return "Debug";
		case TokenType.Default:
			return "Default";
		case TokenType.Delegate:
			return "Delegate";
		case TokenType.Delete:
			return "Delete";
		case TokenType.Deprecated:
			return "Deprecated";
		case TokenType.Do:
			return "Do";
		case TokenType.Double:
			return "Double";
		case TokenType.Else:
			return "Else";
		case TokenType.Enum:
			return "Enum";
		case TokenType.Export:
			return "Export";
		case TokenType.Extern:
			return "Extern";
		case TokenType.False:
			return "False";
		case TokenType.Final:
			return "Final";
		case TokenType.Finally:
			return "Finally";
		case TokenType.Float:
			return "Float";
		case TokenType.For:
			return "For";
		case TokenType.Foreach:
			return "Foreach";
		case TokenType.ForeachReverse:
			return "ForeachReverse";
		case TokenType.Function:
			return "Function";
		case TokenType.Goto:
			return "Goto";
		case TokenType.Idouble:
			return "Idouble";
		case TokenType.If:
			return "If";
		case TokenType.Ifloat:
			return "Ifloat";
		case TokenType.Immutable:
			return "Immutable";
		case TokenType.Import:
			return "Import";
		case TokenType.In:
			return "In";
		case TokenType.Inout:
			return "Inout";
		case TokenType.Int:
			return "Int";
		case TokenType.Interface:
			return "Interface";
		case TokenType.Invariant:
			return "Invariant";
		case TokenType.Ireal:
			return "Ireal";
		case TokenType.Is:
			return "Is";
		case TokenType.Lazy:
			return "Lazy";
		case TokenType.Long:
			return "Long";
		case TokenType.Macro:
			return "Macro";
		case TokenType.Mixin:
			return "Mixin";
		case TokenType.Module:
			return "Module";
		case TokenType.New:
			return "New";
		case TokenType.Nothrow:
			return "Nothrow";
		case TokenType.Null:
			return "Null";
		case TokenType.Out:
			return "Out";
		case TokenType.Override:
			return "Override";
		case TokenType.Package:
			return "Package";
		case TokenType.Pragma:
			return "Pragma";
		case TokenType.Private:
			return "Private";
		case TokenType.Protected:
			return "Protected";
		case TokenType.Public:
			return "Public";
		case TokenType.Pure:
			return "Pure";
		case TokenType.Real:
			return "Real";
		case TokenType.Ref:
			return "Ref";
		case TokenType.Return:
			return "Return";
		case TokenType.Scope:
			return "Scope";
		case TokenType.Shared:
			return "Shared";
		case TokenType.Short:
			return "Short";
		case TokenType.Static:
			return "Static";
		case TokenType.Struct:
			return "Struct";
		case TokenType.String:
			return "String";
		case TokenType.Super:
			return "Super";
		case TokenType.Switch:
			return "Switch";
		case TokenType.Synchronized:
			return "Synchronized";
		case TokenType.Template:
			return "Template";
		case TokenType.This:
			return "This";
		case TokenType.Throw:
			return "Throw";
		case TokenType.True:
			return "True";
		case TokenType.Try:
			return "Try";
		case TokenType.Typedef:
			return "Typedef";
		case TokenType.Typeid:
			return "Typeid";
		case TokenType.Typeof:
			return "Typeof";
		case TokenType.Ubyte:
			return "Ubyte";
		case TokenType.Ucent:
			return "Ucent";
		case TokenType.Uint:
			return "Uint";
		case TokenType.Ulong:
			return "Ulong";
		case TokenType.Union:
			return "Union";
		case TokenType.Unittest:
			return "Unittest";
		case TokenType.Ushort:
			return "Ushort";
		case TokenType.Version:
			return "Version";
		case TokenType.Void:
			return "Void";
		case TokenType.Volatile:
			return "Volatile";
		case TokenType.Wchar:
			return "Wchar";
		case TokenType.While:
			return "While";
		case TokenType.With:
			return "With";
		case TokenType.File:
			return "__File__";
		case TokenType.Line:
			return "__Line__";
		case TokenType.__Gshared:
			return "__Gshared";
		case TokenType.__Thread:
			return "__Thread";
		case TokenType.__Traits:
			return "__Traits";
		case TokenType.atProperty:
			return "atProperty";
		case TokenType.atSafe:
			return "atSafe";
		case TokenType.atTrusted:
			return "atTrusted";
		case TokenType.atSystem:
			return "atSystem";
		case TokenType.atDisable:
			return "atDisable";
		case TokenType.Slash:
			return "Slash";
		case TokenType.SlashAssign:
			return "SlashAssign";
		case TokenType.Dot:
			return "Dot";
		case TokenType.DoubleDot:
			return "DoubleDot";
		case TokenType.TripleDot:
			return "TripleDot";
		case TokenType.Ampersand:
			return "Ampersand";
		case TokenType.AmpersandAssign:
			return "AmpersandAssign";
		case TokenType.DoubleAmpersand:
			return "DoubleAmpersand";
		case TokenType.Pipe:
			return "Pipe";
		case TokenType.PipeAssign:
			return "PipeAssign";
		case TokenType.DoublePipe:
			return "DoublePipe";
		case TokenType.Dash:
			return "Dash";
		case TokenType.DashAssign:
			return "DashAssign";
		case TokenType.DoubleDash:
			return "DoubleDash";
		case TokenType.Plus:
			return "Plus";
		case TokenType.PlusAssign:
			return "PlusAssign";
		case TokenType.DoublePlus:
			return "DoublePlus";
		case TokenType.Less:
			return "Less";
		case TokenType.LessAssign:
			return "LessAssign";
		case TokenType.DoubleLess:
			return "DoubleLess";
		case TokenType.DoubleLessAssign:
			return "DoubleLessAssign";
		case TokenType.LessGreater:
			return "LessGreater";
		case TokenType.LessGreaterAssign:
			return "LessGreaterAssign";
		case TokenType.Greater:
			return "Greater";
		case TokenType.GreaterAssign:
			return "GreaterAssign";
		case TokenType.DoubleGreaterAssign:
			return "DoubleGreaterAssign";
		case TokenType.TripleGreaterAssign:
			return "TripleGreaterAssign";
		case TokenType.DoubleGreater:
			return "DoubleGreater";
		case TokenType.TripleGreater:
			return "TripleGreater";
		case TokenType.Bang:
			return "Bang";
		case TokenType.BangAssign:
			return "BangAssign";
		case TokenType.BangLessGreater:
			return "BangLessGreater";
		case TokenType.BangLessGreaterAssign:
			return "BangLessGreaterAssign";
		case TokenType.BangLess:
			return "BangLess";
		case TokenType.BangLessAssign:
			return "BangLessAssign";
		case TokenType.BangGreater:
			return "BangGreater";
		case TokenType.BangGreaterAssign:
			return "BangGreaterAssign";
		case TokenType.OpenParen:
			return "OpenParen";
		case TokenType.CloseParen:
			return "CloseParen";
		case TokenType.OpenBracket:
			return "OpenBracket";
		case TokenType.CloseBracket:
			return "CloseBracket";
		case TokenType.OpenBrace:
			return "OpenBrace";
		case TokenType.CloseBrace:
			return "CloseBrace";
		case TokenType.QuestionMark:
			return "QuestionMark";
		case TokenType.Comma:
			return "Comma";
		case TokenType.Semicolon:
			return "Semicolon";
		case TokenType.Colon:
			return "Colon";
		case TokenType.Dollar:
			return "Dollar";
		case TokenType.Assign:
			return "Assign";
		case TokenType.DoubleAssign:
			return "DoubleAssign";
		case TokenType.Asterix:
			return "Asterix";
		case TokenType.AsterixAssign:
			return "AsterixAssign";
		case TokenType.Percent:
			return "Percent";
		case TokenType.PercentAssign:
			return "PercentAssign";
		case TokenType.Caret:
			return "Caret";
		case TokenType.CaretAssign:
			return "CaretAssign";
		case TokenType.DoubleCaret:
			return "DoubleCaret";
		case TokenType.Tilde:
			return "Tilde";
		case TokenType.TildeAssign:
			return "TildeAssign";
		case TokenType.opKirbyRape:
			return "opKirbyRape";
		case TokenType.Symbol:
			return "Symbol";
		case TokenType.Number:
			return "Number";
		case TokenType.Begin:
			return "Begin";
		case TokenType.End:
			return "End";
	}
}

public class Token {
	private dstring value;
	private TokenType type;

	public this(TokenType type) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"this");
		debug st.putArgs("string", "type", tokenTypeToString(type));
			
		this.type = type;
	}

	public this(TokenType type, dstring value) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"this");
		debug st.putArgs("string", "type", tokenTypeToString(type), 
			"dstring", "value", value);

		this.type = type;
		this.value = value;
	}

	public TokenType getType() const {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"getType");
		return this.type;
	}

	public dstring getValue() const {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"getValue");
		return this.value;	
	}
}

static assert(TokenType.min == 0);
static assert(tokenToString.length == TokenType.max + 1, "the tokenToString 
	array and TokenType enum are out of sync.");
static assert(TokenType.max + 1 == __traits(allMembers, TokenType).length, 
	"all TokenType enum members must be sequential.");
