#include <iostream>
#include "linkedlist.h"
#include "queue.h"
using namespace std;

class SinglyQueue : public Queue {
	LinkedList* list = new LinkedList();
	
	public:
	void enqueue(int num) {
		list->addTail(num);
	}
	
	int dequeue() {
		if (!isEmpty()) {
			return list->removeHead();
		} 
		cout << "WA LAGI SULOD" << endl;
		return 0;
	}
	
	int first() {
		if (!isEmpty()) {
			return list->getHead();	
		}
		cout << "WA LAGI SULOD" << endl;
		return 0;
	}
	
	int size() {
		return list->_size();
	}
	
	bool isEmpty() {
		return size() == 0;
	}
	
	void print() {
		list->print();
	}
};