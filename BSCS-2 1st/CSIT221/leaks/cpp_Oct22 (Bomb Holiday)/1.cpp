#include "queue.h"
#include "arraylist.h"

class ArrayQueue : public Queue, private ArrayList {
    public:
	void enqueue(int num) {
	    add(num);
	}
	int dequeue() {
	    if (!_size()) return 0;
	    return removeFirst();
	}
	int first() {
	    if (!_size()) return 0;
	    return get(1);
	}
	int size() {
	    return _size();
	}
	bool isEmpty() {
	    return _size() == 0;
	}
	void print() {}
};