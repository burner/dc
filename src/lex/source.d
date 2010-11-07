module lex.source;

import util.stacktrace;

public class Source : Printable {
	private string fileName;
	private string[] file;
	private uint curLine;
	private bool open;

	public this(string fileName, bool open = false) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"this");
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
		if(!this.open) this.openFile();
		return this.file[++this.curLine];
	}

	public uint numberOfLines() {
		if(!this.open) this.openFile();
		return this.file.length;
	}

	public uint currentLineNumber() {
		return this.curLine;
	}

	public bool nextLineExists() {
		if(!this.open) this.openFile();
		return this.file.length > this.curLine+1;
	}

	private void openFile() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"openFile");

	}

	public string getFileName() const {
		return this.fileName;
	}

	public string toString() const {
		return this.fileName;
	}
}
