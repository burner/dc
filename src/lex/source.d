module lex.source;

public class Source {
	private string fileName;
	private string[] file;
	private uint curLine;
	private bool open;

	public this(string fileName, bool open = false) {
		this.fileName = fileName;
		this.file = null;
		this.curLine = 0;
	}

	public this(string fileName, string[] file) {
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
		return this.file.length > this.curLine;
	}

	private void openFile() {

	}
}
