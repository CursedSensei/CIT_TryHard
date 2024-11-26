#include <iostream>
#include "bst.hpp"
using namespace std;

int main(void) {
	BST* bst = new BST();
	char op;
	int input, ind;
	do {
		cout << "Op: ";
		cin >> op;
		switch (op) {
			case 's':
				cin >> input;
				cout << "Is there " << input << "? " << bst->search(input) << endl;
				break;
			case 'i':
				cin >> input;
				bst->insert(input);
				break;
			case 'r':
				cin >> input;
				bst->remove(input);
				break;
			case 'p':
				bst->print();
				break;
			case 'c':
				bst->convertToHeap();
				break;
			case 'x':
				cout << "Exiting" << endl;
				break;
			default:
				cout << "Invalid operation" << endl;
		}
	} while (op != 'x');

	return 0;
}