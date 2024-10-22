#include <cstdlib>
#include <iostream>
#include "list.h"
#include "node.h"
using namespace std;

class LinkedList : public List {
	node* head;
	node* tail;
	int size;
	
	public:
	int removeHead() {
		int elem = head->elem;
		head = head->next;
		size--;
		return elem;
	}
	
	void addTail(int num) {
        add(num);
    }

    void addHead(int num) {
		node* n = (node*) calloc( 1, sizeof(node) );
		n->elem = num;
		if (size == 0) {
			head = n;
			tail = n;
		} else {
			n->next = head;
			head = n;
		}
		size++;
    }
    
    int _size() {
    	return size;
	}
	
	void add(int num) {
		node* n = (node*) calloc( 1, sizeof(node) );
		n->elem = num;
		if (size == 0) {
			head = n;
			tail = n;
		} else {
			tail->next = n;
			tail = n;
		}
		size++;
	}
	
	int getHead() {
		return head->elem;
	}
	
    int get(int pos) {
    	return 0;
    }
    	
    int remove(int num) {
    	node* curr = head;
    	node* prev;
    	while (curr) {
    		if (curr->elem == num) {
    			prev->next = curr->next;
    			size--;
    			return 0;
			}
			prev = curr;
			curr = curr->next;
		}
		return 0;
	}
	
    void print() {
    	node* curr = head;
    	if (size == 0) {
    		cout << "Empty" << endl;
		}
		else {
	    	do {
	    		cout << curr->elem;
	    		if (curr->next) {
	    			cout << " -> ";
				} else {
					cout << endl;
				}
	    		curr = curr->next;
			} while (curr);
		}
    }
};