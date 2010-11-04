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
	private DLinkedList!(DLinkedList!(Token)) buffer;

	public this() {
		super(&run);
		this.stopVar = false;
		this.listModMutex = new Mutex();
		this.noJobQueue = new Semaphore();
		this.buffer = new DLinkedList!(DLinkedList!(Token));
	}

	public void run() {
		//This loop will not be broken because if the parser has nothing to do
		//it will wait at the noJobQueue.
		DLinkedList!(Token) currentStat;
		while(true) {
			this.noJobQueue.wait();
			currentStat = this.syncPop();
			writeln("Parser Run", currentStat.popFront.getType());
			if(this.stopVar && this.buffer.getSize() == 0) return;
		}
	}

	public void syncPush(DLinkedList!(Token) toPush) {
		this.listModMutex.lock();
		this.buffer.pushBack(toPush);
		this.listModMutex.unlock();
		this.noJobQueue.notify();
	}

	private DLinkedList!(Token) syncPop() {
		this.listModMutex.lock();
		return this.buffer.popFront();
		this.listModMutex.unlock();
	}

	public void stop() {
		this.stopVar = true;	
	}

	public void increCount() {
		this.noJobQueue.notify();
	}
}
