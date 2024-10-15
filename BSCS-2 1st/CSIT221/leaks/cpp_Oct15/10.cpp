// TODO change this to handle char elements

#include <iostream>
#include "arraylist.h"
#include "stack.h"
using namespace std;

class ArrayStack : public Stack {
	ArrayList* list = new ArrayList();
	public:

    // TODO push
	void push(char num) {
        list->add(num);
	}

    // TODO pop
	char pop() {
        return list->removeLast();
	}

    // TODO top
	char top() {
        return list->get();
	}

    // TODO size
	int size() {
        return list->_size();
	}

    // TODO isEmpty
	bool isEmpty() {
        return list->_size() <= 0;
	}

	void print() {
		list->print();
	}
};