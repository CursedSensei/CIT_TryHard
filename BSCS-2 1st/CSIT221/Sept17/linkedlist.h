#include "list.h"
#include "node.h"

using namespace std;

class LinkedList : public List {
	node* head, tail;
	int size = 0;
	
public:
	void add(int arg) {
		node *cur = new node;
		cur->elem = arg;
		cur->next = nullptr;
		
		if (size) {
			head = cur;
			tail = cur;
		} else {
			tail->next = cur;
			tail = cur;
		}
	}
	void print() {
		if (size == 0) {
			cout << "Empty" << endl;
			return;
 		}
 		
 		node *cur = head;
 		
 		while (cur) {
 			cout << cur->elem << " -> ";
 			cur = cur->next;
		}
		
		cout << endl;
	}
	int get(int pos) {
		
	}
	int remove(int val) {
		
	}
};
