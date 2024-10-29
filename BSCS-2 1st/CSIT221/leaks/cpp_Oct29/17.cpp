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

    // TODO add remove method here
    int remove(node *n) {
        if (n->left && n->right) throw logic_error("Cannot remove " + to_string(n->elem) + " for it has 2 children");
        
        
        if (n->left) {
            if (n == root) {
                root = n->left;
                n->left->parent = nullptr;
            } else if (n->parent->left == n) {
                n->parent->left = n->left;
                n->left->parent = n->parent;
            } else {
                n->parent->right = n->left;
                n->left->parent = n->parent;
            }
        } else if (n->right) {
            if (n == root) {
                root = n->right;
                n->right->parent = nullptr;
            } else if (n->parent->left == n) {
                n->parent->left = n->right;
                n->right->parent = n->parent;
            } else {
                n->parent->right = n->right;
                n->right->parent = n->parent;
            }
        } else {
            if (n == root) root = nullptr;
            else if (n->parent->left == n) n->parent->left = nullptr;
            else n->parent->right = nullptr;
        }
        
        int ret = n->elem;
        free(n);
        size--;
        return ret;
    }


    // DO NOT modify the code below.
	node* addLeft(node* p, int e) {
		if (p->left) {
			throw logic_error(to_string(p->elem) + " already has left child");
		}
		node* n = create_node(e, p);
		p->left = n;
		size++;
		return n;
	}

    // COPY your implementation
	node* addRight(node* p, int e) {
        if (p->right) {
			throw logic_error(to_string(p->elem) + " already has left child");
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