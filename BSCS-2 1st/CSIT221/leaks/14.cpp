// TODO create the SinglyQueue

#include "linkedlist.hpp"
#include "queue.hpp"

class SinglyQueue : public Queue {
    LinkedList * list = new LinkedList();

public:
    ~SinglyQueue() {
        delete list;
    }
    
	void enqueue(string s) {
	    list->addTail(s);
	}

	string dequeue() {
	    if (isEmpty()) return "(none)";
	    return list->removeHead();
	}
	string first() {
	    if (list->_size()) return list->getHead();
	    return "(none)";
	}
	int size() {
	    return list->_size();
	}
	bool isEmpty() {
	    return list->_size() == 0;
	}
	void print() {
	    list->print();
	}
};