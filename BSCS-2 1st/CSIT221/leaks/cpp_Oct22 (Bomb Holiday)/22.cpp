// ALREADY IMPLEMENTED
// Go to arraylist.h's methods.

#include <iostream>
#include "circulardeque.h"
using namespace std;

int main() {
	Deque* deque = new CircularDeque();
    int input;
    char op;
    do {
    	cout << "Enter op: ";
    	cin >> op;
    	switch (op) {
    		case 'f' :
		    	cin >> input;
		    	deque->addFirst(input);
		    	break;
    		case 'l' :
		    	cin >> input;
		    	deque->addLast(input);
		    	break;
		    case 'F':
		    	cout << "Removed " << deque->removeFirst() << endl;
		    	break;
		    case 'L':
		    	cout << "Removed " << deque->removeLast() << endl;
		    	break;
		    case 's':
		    	cout << "Size: " << deque->size() << endl;
		    	break;
		    case '?':
		    	cout << "Empty? " << deque->isEmpty() << endl;
		    	break;
		    case 'p':
		    	deque->print();
		    	break;
		    case 'x':
		    	cout << "Exiting";
		    	break;
		}
	} while (op != 'x');

    return 0;
}