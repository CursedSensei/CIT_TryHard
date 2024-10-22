#include <iostream>
#include "arrayqueue.h"
using namespace std;

int main() {
    Queue* queue = new ArrayQueue();
    int input;
    char op;
    do {
    	cout << "Enter op: ";
    	cin >> op;
    	switch (op) {
    		case 'e' :
		    	cin >> input;
		    	queue->enqueue(input);
		    	break;
		    case 'd':
		    	cout << "Removed " << queue->dequeue() << endl;
		    	break;
		    case 'f':
		    	cout << "First element: " << queue->first() << endl;
		    	break;
		    case 's':
		    	cout << "Size: " << queue->size() << endl;
		    	break;
		    case '?':
		    	cout << "Empty? " << queue->isEmpty() << endl;
		    	break;
		    case 'p':
		    	queue->print();
		    	break;
		    case 'x':
		    	cout << "Exiting";
		    	break;
		}
	} while (op != 'x');
    return 0;
}