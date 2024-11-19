// DO NOT modify this file.
// Go to bst's remove method

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

	node* left(node* p) {
		return p->left;
	}

	node* right(node* p) {
		return p->right;
	}

	node* sibling(node* n) {
		node* par = n->parent;
		if (!par) {
			return NULL;
		}
		if (n == par->left) {
			return par->right;
		}
		return par->left;
	}

	node* addLeft(node* p, int e) {
		if (p->left) {
			throw logic_error(to_string(p->elem) + " already has left child");
		}
		node* n = create_node(e, p);
		p->left = n;
		size++;
		return n;
	}

	node* addRight(node* p, int e) {
		if (p->right) {
			throw logic_error(to_string(p->elem) + " already has right child");
		}
		node* n = create_node(e, p);
		p->right = n;
		size++;
		return n;
	}

    // TODO complete remove
    int remove(node* n) {
        int res = n->elem;

        if (left(n) && right(n)) {
            node * cur = right(n);
            
            while (left(cur)) {
                cur = left(cur);
            }
            
            n->elem = cur->elem;
            if (right(cur)) {
                if (cur->parent == n) {
                    n->right = right(cur);
                } else {
                    cur->parent->left = right(cur);
                }
                right(cur)->parent = cur->parent;
            } else {
                if (cur->parent != n) cur->parent->left = NULL;
                else cur->parent->right = NULL;
            }
            
            free(cur);
        } else if (left(n)) {
            if (n->parent) {
                if (n->parent->left == n) {
                    n->parent->left = n->left;
                } else {
                    n->parent->right = n->left;
                }
                n->left->parent = n->parent;
            } else {
                root = left(n);
                root->parent = NULL;
            }
            free(n);
        } else if (right(n)) {
            if (n->parent) {
                if (n->parent->left == n) {
                    n->parent->left = n->right;
                } else {
                    n->parent->right = n->right;
                }
                n->right->parent = n->parent;
            } else {
                root = right(n);
                root->parent = NULL;
            }
            free(n);
        } else {
            if (n->parent) {
                if (n->parent->left == n) {
                    n->parent->left = NULL;
                } else {
                    n->parent->right = NULL;
                }
            } else {
                root = NULL;
            }
        
            free(n);
        }
        
        size--;
        return res;
    }

	node* getRoot() {
		return root;
	}

	void print() {
		cout << "Size: " << size << endl;
		if (!root) {
			cout << "EMPTY" << endl;
			return;
		}
		node* curr = root;
		print_node("", root, false);
        cout << "Status: " << check_parent(root, NULL) << endl;
	}

	void print_node(string prefix, node* n, bool isLeft) {
		cout << prefix;
        cout << (isLeft ? "+--L: " : "+--R: " );
        cout << n->elem << endl;
		if (n->left) {
			print_node(prefix + "|   ", n->left, true);
		}
		if (n->right) {
			print_node(prefix + "|   ", n->right, false);
		}
	}

    bool check_parent(node* curr, node* par) {
        if (!curr) {
            return true;
        }
        if (curr->parent != par) {
            return false;
        }
        return check_parent(curr->left, curr) && check_parent(curr->right, curr);
    }
};