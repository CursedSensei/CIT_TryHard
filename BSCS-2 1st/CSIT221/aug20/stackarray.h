#include "stack.h"
#include "arraylist.h"
class StackArray : private ArrayList, public Stack {
	public:
	void push(int e) {
		add(e);
	}
	int pop() {
		return removeLast();
	}
	int top() {
		return get(_size());
	}
	int size() {
		return _size();
	}
	bool isEmpty() {
		return _size() <= 0;
	}
};
