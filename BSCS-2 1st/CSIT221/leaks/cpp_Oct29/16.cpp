#include "node.h"
#include <iostream>
using namespace std;

class BinaryTree {
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
            if (!curr->parent && par) {
                cout << "Illegal parent of " << curr->elem << ": NULL -- must be " << par->elem << endl;
            } else if (!par && curr->parent) {
                cout << "Illegal parent of " << curr->elem << ": " << curr->parent->elem << " -- must be NULL" << endl;
            } else {
                cout << "Illegal parent of " << curr->elem << ": " << curr->parent->elem << " -- must be " << par->elem << endl;
            }
            return false;
        }
        return check_parent(curr->left, curr) && check_parent(curr->right, curr);
    }

	public:
	virtual node* left(node*) = 0;
	virtual node* addRoot(int e) = 0;
	virtual node* addLeft(node* p, int e) = 0;
	virtual node* addRight(node* p, int e) = 0;
	virtual node* getRoot() = 0;
	virtual int getSize() = 0;
	virtual int remove(node* n) = 0;

	void print() {
		cout << "Size: " << getSize() << endl;
		if (!getRoot()) {
			cout << "EMPTY" << endl;
			return;
		}
		node* curr = getRoot();
		print_node("", getRoot(), false);
        cout << "Status: " << check_parent(getRoot(), NULL) << endl;
	}
};