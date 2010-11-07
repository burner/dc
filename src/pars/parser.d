module pars.parser;

import core.thread;
import core.sync.semaphore;
import core.sync.mutex;
import std.stdio;

import container.dlst;
import lex.token;

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
		//This loop will not be broken because if the parser has nothing to do
		//it will wait at the noJobQueue.
		DLinkedList!(Token) currentStat;
		while(true) {
			this.noJobQueue.wait();
			currentStat = this.syncPop();
			int idx = 0;
			Token next = currentStat.popFront();
			while(!(next is null)) {
				idx++;
				write(next.getType(), " ");
				next = currentStat.popFront();
			}
			writeln(idx);
			if(this.stopVar && this.buffer.getSize() == 0) return;
		}
	}

	public void syncPush(Token toPush) {
		this.listModMutex.lock();
		debug writeln("pushed new Token ", toPush.getType());
		this.buffer.pushBack(toPush);
		
		if(toPush.getType() == TokenType.Semicolon) {
			this.buffer = new DLinkedList!(Token);
			this.bufferList.pushBack(this.buffer);
		}
		this.listModMutex.unlock();
		this.noJobQueue.notify();
	}

	private DLinkedList!(Token) syncPop()
		in { 
			this.listModMutex.lock();
		}
		out {
			this.listModMutex.unlock();
		}
		body {
			return this.bufferList.popFront();
		}

	public void stop() {
		this.stopVar = true;	
	}

	public void increCount() {
		this.noJobQueue.notify();
	}
}
