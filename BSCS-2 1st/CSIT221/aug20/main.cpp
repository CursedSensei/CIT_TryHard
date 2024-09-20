#include <iostream>
#include "arraylist.h"

using namespace std;

int main() {
	List *list = new ArrayList();
	list->add(13);
	list->add(4);
	list->add(7);
	list->print();
	
	cout << "2nd Elem: " << list->get(2) << endl;
	cout << "Removing 13 at pos " << list->remove(13) << endl;
	
	list->print();
	
	delete list;
	
	return 0;
}
