module pars.parser;

import core.thread;
import core.sync.semaphore;
import core.sync.mutex;
import std.stdio;

import container.dlst;
import lex.token;
import util.stacktrace;

public class Parser : Thread {
	public Semaphore noJobQueue;
	public Mutex listModMutex;

	private DLinkedList!(Token) workingSet;
	private bool stopVar;
	private DLinkedList!(Token) buffer;
	private DLinkedList!(DLinkedList!(Token)) bufferList;

	public this() {
		super(&run);
		this.stopVar = false;
		this.listModMutex = new Mutex();
		this.noJobQueue = new Semaphore();
		this.buffer = new DLinkedList!(Token);
		this.bufferList = new DLinkedList!(DLinkedList!(Token));
		this.bufferList.pushBack(this.buffer);
	}

	public void run() {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"run");
		//This loop will not be broken because if the parser has nothing to do
		//it will wait at the noJobQueue.
		DLinkedList!(Token) currentStat;
		while(true) {
			//Us noJobQueue to wait if there is nothing to do.
			this.noJobQueue.wait();

			try {
				currentStat = this.syncPop();
			} catch(Exception e) {
				return;
			}

			foreach(Token it; currentStat) {
				write(tokenTypeToString(it.getType()), " ");
			}
			writeln();
			if(this.stopVar && this.buffer.getSize() == 0) return;
		}
	}

	public void syncPush(Token toPush) {
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"syncPush");

		this.listModMutex.lock();
		debug {
			if(toPush.getType() != TokenType.Identifier) {
				writeln("pushed new Token ", 
					tokenTypeToString(toPush.getType()));
			} else {
				writeln("pushed new Token ", 
					tokenTypeToString(toPush.getType())," ",
					 toPush.getValue());
			}
		}
				
		this.buffer.pushBack(toPush);
		
		if(toPush.getType() == TokenType.Semicolon) {
			this.buffer = new DLinkedList!(Token);
			this.bufferList.pushBack(this.buffer);
		}
		this.noJobQueue.notify();
		this.listModMutex.unlock();
	}

	private DLinkedList!(Token) syncPop()
		in { 
		debug scope StackTrace st = new StackTrace(__FILE__, __LINE__,
			"syncPop");
			
			this.listModMutex.lock();
		}
		out {
			this.listModMutex.unlock();
		}
		body {
			if(this.bufferList.getSize() > 0) {
				return this.bufferList.popFront();
			} else {
				throw new Exception("bufferList is empty");
			}
		}

	public void stop() {
		this.stopVar = true;	
	}

	public void increCount() {
		this.noJobQueue.notify();
	}
}
