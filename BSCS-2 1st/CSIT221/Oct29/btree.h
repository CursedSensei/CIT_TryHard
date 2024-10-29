#include "node.h"
#include <iostream>
#include <stdexcept>
#include <string.h>
using namespace std;

class BinaryTree {
	node* root;
	int size;
	
	void print(node* n) { // in-order traversals
		if (n->left) {
			print(n->left);
		}
		cout << n->elem << endl;
		if (n->right) {
			print(n->right);
		}
	}
	
	public:
	BinaryTree() {
		root = NULL;
		size = 0;
	}
	
	node* addRoot(int num) {
		if (root) throw logic_error("Root node already exist");
		
		root = new node;
		memset(root, 0, sizeof(node));
		root->elem = num;
		size++;
		return root;
	}
	
	node* addLeft(node* p, int num) {
		if (p->left != 0) throw logic_error("Left node already exist");
		
		node *n = new node;
		memset(&(n->left), 0, sizeof(n->left) * 2);
		n->elem = num;
		n->parent = p;
		size++;
		p->left = n;
		return n;
	}
	
	void print() { 
		cout << "Size: " << size << endl;
		print(root);
	}
};
