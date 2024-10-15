#include <iostream>
#include "stackarray.h"
using namespace std;

int main() {
	Stack* stack = new StackArray();
	stack->push(5);
	stack->push(3);
	cout << "Size: " << stack->size() << endl; // 2
	cout << "Pop: " << stack->pop() << endl; // 3
	cout << "Pop: " << stack->pop() << endl; // 5
	cout << "Is Empty: " << stack->isEmpty() << endl; // 1
	stack->push(7); 
	stack->push(9);
	stack->push(4);
	cout << "Pop: " << stack->pop() << endl; // 4
	cout << "Is Empty: " << stack->isEmpty() << endl; // 0
	stack->push(6);
	stack->push(8);
	cout << "Pop: " << stack->pop() << endl; // 8
	cout << "Size: " << stack->size() << endl; // 3
	
	delete stack;
//	char op;
//	int num;
//	while (true) {
//		cout << "op: ";
//		cin >> op;
//		switch(op) {
//			case 'a':
//				cin >> num;
//				list->add(num);
//				break;
//			case 'p':
//				list->print();
//				break; 
//		}
//	}
//	list->print();
//	cout << sizeof(ArrayList);
//	cout << "2nd elem: "<<list->get(2)<<endl;
////	cout << "Removing 13 at pos " <<list->remove(13)<<endl;
//	list->print();
	return 0;
}
