#include "list.h"
#include <iostream>
#include <cmath>
#include "node.h"
using namespace std;

class DoublyLL : public List {
	node *head, *tail;
	int size;

	void addBetween(int num, node* pred, node* succ) {
		node* n = (node*) malloc( sizeof(node) );
		n->elem = num;
		n->next = succ;
		n->prev = pred;
		pred->next = n;
		succ->prev = n;
		size++;
	}

	void removeNode(node* n) {
        // IGNORE
	}

public:
	DoublyLL() {
		head = (node*) calloc(1, sizeof(node));
		tail = (node*) calloc(1, sizeof(node));
		head->next = tail;
		tail->prev = head;
		size = 0;
	}

	void addFirst(int num) {
		addBetween(num, head, head->next);
	}

	void addLast(int num) {
		addBetween(num, tail->prev, tail);
	}

	void removeFirst() {
		if (size == 0) {
			return;
		}
		head = head->next;
		if (head) {
			free(head->prev);
			head->prev = nullptr;
		} else {
			free(tail);
			tail = nullptr;
		}
		size--;
	}

	void removeLast() {
		if (size == 0) {
			return;
		}
		tail = tail->prev;
		if (tail) {
			free(tail->next);
			tail->next = nullptr;
		} else {
			free(head);
			head = nullptr;
		}
		size--;
	}

	int add(int num) {
        // TODO implement add
	}

	int get(int pos) {
		node* curr = head;
		int ctr = 1;
		while (ctr != pos) {
			curr = curr->next;
			ctr++;
		}
		return curr->elem;
	}

	int remove(int num) {
		node* curr = head->next;
		int pos = 1;
		while (curr != tail) {
			if (curr->elem == num) {
				removeNode(curr);
				return pos;
			}
			curr = curr->next;
			pos++;
		}
		return -1;
	}

	void print() {
		cout << "Size: " << size << endl;
		node* curr = head->next;
		cout << "From HEAD: ";
		while (curr != tail) {
			cout << curr->elem;
			curr = curr->next;
            if (curr != tail) {
                cout << "->";
            }
		}
		curr = tail->prev;
		cout << endl << "From TAIL: ";
		while (curr != head) {
			cout << curr->elem;
			curr = curr->prev;
            if (curr != head) {
                cout << "<-";
            }
		}
		cout << endl;
	}
};