#include <stdexcept>
#include <iostream>
#include <cstdlib>
#include "gentree.h"
using namespace std;

class MyGenTree : public GenTree {
	node* root;
	int size;

    node *create_node(int elem) {
        node *n = new node;
        n->num_child = 0;
        n->parent = 0;
        n->elem = elem;
        n->children = (node **)malloc(0);
        size++;
        return n;
    }
    
    void resizeChildren(node *p) {
        p->children = (node **)realloc(p->children, sizeof(node *) * p->num_child);
    }
    
    void thatChildIsNotMine(node *c) {
        for (int i = 0; i < c->parent->num_child; i++) {
            if (c->parent->children[i] == c) {
                for (int j = i + 1; j < c->parent->num_child; j++) {
                    c->parent->children[j - 1] = c->parent->children[j];
                }
                break;
            }
        }
        
        c->parent->num_child--;
        resizeChildren(c->parent);
    }

	public:
	node* addRoot(int e) {
		if (root) throw logic_error("Already has root");
		
		node *n = create_node(e);
		root = n;
		
        return n;
	}

	node* addChild(node* p, int e) {
		node *n = create_node(e);
		
		p->num_child++;
		resizeChildren(p);
		p->children[p->num_child - 1] = n;
		n->parent = p;

        return n;
	}


	void remove(node* n) {
		// TODO implementation [+35 pts]
		if (n->num_child) throw logic_error(to_string(n->elem) + " has children");
		
		if (n->parent) {
		    thatChildIsNotMine(n);
		} else {
		    root = nullptr;
		}
		
		delete n;
		size--;
	}

	int getSize() {
	    return size;
	}

	node* getRoot() {
	    return root;
	}
};