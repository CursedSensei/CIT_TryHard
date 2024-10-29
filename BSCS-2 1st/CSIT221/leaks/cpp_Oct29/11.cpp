// DO NOT modify this file
#include <cstdlib>
#include <iostream>
#include "binarytree.h"
using namespace std;

class MyBinaryTree : public BinaryTree {
	node* root;
	int size;

	node* create_node(int e, node* parent) {
		node* n = (node*) calloc( 1, sizeof(node) );
		n->elem = e;
		n->parent = parent;
		return n;
	}

	public:
	node* addRoot(int e) {
		if (root) {
			throw logic_error("Already has root");
		}
		node* n = create_node(e, NULL);
		root = n;
		size++;
		return n;
	}

	node* left(node* n) {
		return n->left;
	}

	node* right(node* n) {
		return n->right;
	}

	node* addLeft(node* p, int e) {
		if (p->left) {
			throw logic_error("Left of " + to_string(p->elem) + " exists");
		}
		node* n = create_node(e, p);
		p->left = n;
		size++;
		return n;
	}

    // COPY your implementation
	node* addRight(node* p, int e) {
        if (p->right) {
			throw logic_error("Right of " + to_string(p->elem) + " exists");
		}
		node* n = create_node(e, p);
		p->right = n;
		size++;
		return n;
	}

    int getSize() {
        return size;
    }

	node* getRoot() {
		return root;
	}
};