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
    // TODO if necessary
	int removeHead() {
	    if (head) {
	        int ret = head->elem;
	        node *next = head->next;
	        delete head;
	        head = next;
	        size--;
	        return ret;
	    }
	
        return 0;
	}

    // TODO if necessary
	void addTail(int num) {

    }

    // TODO if necessary
    void addHead(int num) {
        node *n = new node;
        n->elem = num;
        if (head) {
            n->next = head;
            head = n;
        } else {
            head = n;
            n->next = NULL;
        }
        size++;
    }

    // TODO if necessary
    void add(int num) {

    }

    // TODO add more methods as necessary

    int _size() {
    	return size;
	}

    int get(int pos) {
    	return 0;
    }
    
    int get() {
        if (head) {
            return head->elem;
        }
        return 0;
    }

    int remove(int num) {
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