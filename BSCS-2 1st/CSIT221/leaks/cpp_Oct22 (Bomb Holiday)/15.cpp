#include "list.h"
#include "node.h"
#include <iostream>
#include <cmath>
using namespace std;

class LinkedList : public List {
	node *head, *tail;
	int size;

public:
    LinkedList() {
        head = new node;
        tail = new node;
        head->next = tail;
        tail->prev = head;
        
        size = 0;
    }

    // TODO implement
	void addHead(int num) {
	    node *n = new node;
	    n->elem = num;
	    n->next = head->next;
	    n->prev = head;
	    head->next->prev = n;
	    head->next = n;
	    
	    size++;
	}

    // TODO implement
	void addTail(int num) {
	    node *n = new node;
	    n->elem = num;
	    n->prev = tail->prev;
	    n->next = tail;
	    tail->prev->next = n;
	    tail->prev = n;
	    
	    size++;
	}

    // TODO implement
	int removeTail() {
		if (!size) return 0;
		
		node *n = tail->prev;
		n->prev->next = tail;
		tail->prev = n->prev;
		
		int ret = n->elem;
		delete n;
		size--;
		
		return ret;
	}

    // TODO implement
	int removeHead() {
		if (!size) return 0;
		
		node *n = head->next;
		n->next->prev = head;
		head->next = n->next;
		
		int ret = n->elem;
		delete n;
		size--;
		
		return ret;
	}

    // TODO implement
	int getSize() {
        return size;
	}

	void add(int num) {
		addTail(num);
	}

    int remove(int num) {
        // IGNORE this
        return 0;
	}

    int get(int pos) {
        // IGNORE this
        return 0;
	}

    // TODO implement print method
    void print() {
    	node* curr;
    	if (size == 0) {
    		cout << "Empty" << endl;
		} else {
			cout << "From HEAD: ";
            // TODO print all elements from first to last, separated by ->
            cout << head->next->elem;
            
            node *cur = head->next->next;
            while (cur != tail) {
                cout << " -> " << cur->elem;
                cur = cur->next;
            }
            
			cout << endl << "From TAIL: ";
            // TODO print all elements from last to first, separated by <-
            cout << tail->prev->elem;
            
            cur = tail->prev->prev;
            while (cur != head) {
                cout << " <- " << cur->elem;
                cur = cur->prev;
            }
            cout << endl;
		}
    }
};