#include "list.h"
#include <iostream>
#include "node.h"
using namespace std;

class CircularLL : public List {
	node* tail = NULL;
	int size = 0;

    node * createNode(int num) {
        node * n = new node;
        n->elem = num;
        return n;
    }

public:
	void add(int num) {
		addFirst(num);
	}

	void addFirst(int num) {
	    node *n = createNode(num);
	
        if (!tail) {
            tail = n;
            n->next = tail;
        } else {
            n->next = tail->next;
            tail->next = n;
        }
        
        size++;
	}

	void addLast(int num) {
	    node *n = createNode(num);
	
        if (!tail) {
            tail = n;
            n->next = tail;
        } else {
            n->next = tail->next;
            tail->next = n;
            tail = n;
        }
        
        size++;
	}

	int get(int pos) {
		// IGNORE
		return 0;
	}

	int getTail() {
        if (tail) {
            return tail->elem;
        }
        return -1;
	}

	void rotate() {
        if (tail) {
            tail = tail->next;
        }
	}

    int remove(int num) {
        return 0;
    }

	int removeFirst() {
	    if (!size) return -1;
	
		node *n = tail->next;
		int ret = n->elem;
		if (n == tail) {
		    tail = NULL;
		} else {
		    tail->next = n->next;
		}
		delete n;
		size--;
		return ret;
	}

	void print() {
		cout << "Size: " << size << endl;
        if (!size) {
            cout << "Empty" << endl;
            return;
        }
        
        cout << tail->next->elem;
        node * cur = tail->next->next;
        
        while (cur != tail->next) {
            cout << "->" << cur->elem;
            cur = cur->next;
        }
        
        cout << "->" << tail->next->elem << endl;
	}
};