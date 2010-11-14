module lex.source;

import util.stacktrace;

public class Source : Printable {
	private string fileName;
	private string[] file;
	private uint curLine;
	private bool open;

	public this(string fileName, bool open = false) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"Source.this");
		debug st.putArgs("string", "fileName", fileName, 
			"bool", "open", open);

		this.fileName = fileName;
		this.file = null;
		this.curLine = 0;
	}

	public this(string fileName, string[] file) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"this");
		debug st.putArgs("string", "fileName", fileName, 
			"string", "file", "stringArray");

		this.fileName = fileName;
		this.file = file;
		this.curLine = 0;
		this.open = true;
	}

	public string getNextLine() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"getNextLine");
		if(!this.open) this.openFile();
		return this.file[this.curLine++];
	}

	public uint numberOfLines() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"numberOfLines");
		if(!this.open) this.openFile();
		return this.file.length;
	}

	public uint currentLineNumber() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"currentLineNumber");
		return this.curLine;
	}

	public bool nextLineExists() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"nextLineExists");
		if(!this.open) this.openFile();
		return this.file.length > this.curLine;
	}

	private void openFile() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"openFile");

	}

	public string getFileName() const {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"getFileName");
		return this.fileName;
	}

	override public string toString() const {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"toString");
		return this.fileName;
	}
}
