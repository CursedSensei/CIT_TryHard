#include "node.h"
#include <iostream>
#include <cstdlib>
using namespace std;

class GenTree {
	void print_node(string prefix, node* n) {
		cout << prefix;
        cout << "+-->: ";
        cout << n->elem << endl;
		for (int i = 0; i < n->num_child; i++) {
			print_node(prefix + "|   ", n->children[i]);
		}
	}

    bool check_parent(node* curr, node* par) {
        if (!curr) {
            return true;
        }
        if (curr->parent != par) {
            return false;
        }
        bool res = true;
		for (int i = 0; i < curr->num_child; i++) {
			res &= check_parent(curr->children[i], curr);
		}
        return res;
    }

	public:
	virtual node* addRoot(int) = 0;
	virtual node* addChild(node*, int) = 0;
	virtual void remove(node*) = 0;
	virtual int getSize() = 0;
	virtual node* getRoot() = 0;

	void print() {
		cout << "Size: " << getSize() << endl;
		if (!getRoot()) {
			cout << "EMPTY" << endl;
			return;
		}
		node* curr = getRoot();
		print_node("", getRoot());
        cout << "Status: " << check_parent(getRoot(), NULL) << endl;
	}
};