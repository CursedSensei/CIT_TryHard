#include "list.h"
#include "node.h"
#include <iostream>
using namespace std;

class LinkedList : public List {
	node* head;
	node* tail;
	int size;
	
	node *createNode(int num) {
		node *ret = new node;
		ret->next = nullptr;
		ret->prev = nullptr;
		ret->elem = num;
		
		return ret;
	}
	
	void takeNode(node *n) {
		if (n->next) {
			n->next->prev = n->prev;
		}
		if (n->prev) {
			n->prev->next = n->next;
		}
	}
	
	public:
	void print() {
		if (size == 0) {
			cout << "Empty" << endl;
			return;
		}
		cout << "First Element: " << head->elem << endl;
		cout << "Last  Element: " << tail->elem << endl << "From HEAD: ";
		node* curr = head;
		while (curr) {
			cout << curr->elem << " -> ";
			curr = curr->next;
		}
		cout << endl << "From TAIL: ";
		curr = tail;
		while (curr) {
			cout << curr->elem << " <- ";
			curr = curr->prev;
		}
		cout << endl;
	}
	
	int get(int pos) {
		node* curr = head;
		for (int i = 1; i < pos; i++) {
			curr = curr->next;
		}
		return curr->elem;
	}
	
	void addHead(int num) {
		node *n = createNode(num);
		
		n->next = head;
		head = n;
		
		if (!size++) {
			tail = n;
		} else {
			n->next->prev = n;
		}
	}
	
	void addTail(int num) {
		node *n = createNode(num);
		
		if (!size++) {
			head = n;
		} else {
			tail->next = n;
			n->prev = tail;
		}
		
		tail = n;
	}
	
	
	void add(int num) {
		addTail(num);
	}
	
	
	int removeHead() {
		int ret = 0;
		
		if (head) {
			node *n = head;
			
			head = n->next;
			ret = n->elem;
			
			delete n;
			
			if (--size) {
				head->prev = nullptr;
			} else {
				tail = nullptr;
			}
		}
		
		return ret;
	}
	
	int removeTail() {
		int ret = 0;
		
		if (tail) {
			node *n = tail;
			tail = n->prev;
			ret = n->elem;
			
			delete n;
			
			if (--size) {
				tail->next = nullptr;
			} else {
				head = nullptr;
			}
		}
		
		return ret;
	}
	
	
	int remove(int num) {		
		if (!size) return 0;
		
		if (head->elem == num) {
			return removeHead();
		} else if (tail->elem == num) {
			return removeTail();
		}
		
		node *n = head->next;
		int pos = 2;
		
		while (n) {
			if (n->elem == num) {
				takeNode(n);
				delete n;
				size--;
				return pos;
			}
			pos++;
		}
		
		return 0;
	}
};
