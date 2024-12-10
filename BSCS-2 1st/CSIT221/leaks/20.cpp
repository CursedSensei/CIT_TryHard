#include <iostream>
#include "stack.hpp"
#include "arraylist.hpp"
using namespace std;

class ArrayStack : public Stack {
	ArrayList* list = new ArrayList();
	public:
	void push(int num) {
		list->add(num);
	}

	int pop() {
		if (isEmpty()) {
			cout << "WAY SULOD OI" << endl;
			return 0;
		}
		return list->removeLast();
	}

	int top() {
		if (isEmpty()) {
			cout << "WAY SULOD OI" << endl;
			return 0;
		}
		return list->get(size());
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