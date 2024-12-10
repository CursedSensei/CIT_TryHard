#include <cstdlib>
#include <iostream>

using namespace std;
#include "list.hpp"
#include "node.hpp"

class LinkedList : public List {
	node* head = NULL;
	node* tail = NULL;
	int size = 0;

	public:
	~LinkedList() {
	    while (size--) {
	        removeHead();
	    }
	}
	
	string removeHead() {
		string elem = head->elem;
		head = head->next;
		size--;
		return elem;
	}

	void addTail(string num) {
        add(num);
    }

    void addHead(string num) {
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

	void add(string num) {
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

	string getHead() {
		return head->elem;
	}

    string get(int pos) {
    	return "(none)"; // ill be back if i need u
    }

    string remove(string num) {
    	node* curr = head;
    	node* prev;
    	while (curr) {
    		if (curr->elem == num) {
    			prev->next = curr->next;
    			size--;
    			return "(none)";
			}
			prev = curr;
			curr = curr->next;
		}
    	return "(none)";
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